import 'package:flutter/material.dart';
import 'package:movies/core/widgets/error_state_widget.dart';
import 'package:movies/providers/favourites_provider.dart';
import 'package:movies/providers/profile_provider.dart';
import 'package:movies/screens/home_screen/tabs/profile_tab/widgets/empty_list_widget.dart';
import 'package:movies/screens/home_screen/tabs/profile_tab/widgets/profile_grid.dart';
import 'package:movies/screens/home_screen/tabs/profile_tab/widgets/profile_header_widget.dart';
import 'package:movies/screens/home_screen/tabs/profile_tab/widgets/profile_tab_bar.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/profile_response/profile_data.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late ProfileProvider _profileProvider;
  late FavouritesProvider _favouritesProvider;
  int _currentTab = 0;
  bool _historyNotSelected = true;

  void _loadProfile() async {
    _profileProvider = ProfileProvider();
    _favouritesProvider = FavouritesProvider();
    await _profileProvider.getProfile();
    await _favouritesProvider.getProfile();
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _profileProvider),
        ChangeNotifierProvider.value(value: _favouritesProvider),
      ],
      child: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          var profileState = provider.profileState;
          switch (profileState) {
            case ProfileSuccessState():
              return Consumer<FavouritesProvider>(
                builder: (context, favProvider, _) {
                  FavouritesState favState = favProvider.state;
                  switch (favState) {
                    case FavouritesSuccessState():
                      return Column(
                        children: [
                          Visibility(
                            visible: _historyNotSelected,
                            child: ProfileHeaderWidget(
                              name: ProfileData.userProfile!.name!,
                              phone: ProfileData.userProfile!.phone!,
                              watchListCount: favState.data.length.toString(),
                              historyCount: 5,
                              avatarIndex: int.parse(
                                ProfileData.userProfile!.avaterId.toString(),
                              ),
                            ),
                          ),
                          ProfileTabBar(
                            onTap: (index) {
                              setState(() {
                                _currentTab = index;
                                _currentTab == 1
                                    ? _historyNotSelected = false
                                    : _historyNotSelected = true;
                              });
                            },
                          ),
                          if (_historyNotSelected)
                            favState.data.isNotEmpty
                                ? Expanded(
                              child: ProfileGrid(
                                favMovies: favState.data,
                              ),
                            )
                                : Expanded(child: EmptyListWidget()),
                          if (!_historyNotSelected)
                            Expanded(child: EmptyListWidget())
                        ],
                      );
                    case FavouritesLoadingState():
                      return Center(child: CircularProgressIndicator());
                    case FavouritesErrorState():
                      return ErrorStateWidget(
                        serverError: favState.serverError,
                        exception: favState.exception,
                      );
                  }
                },
              );
            case ProfileLoadingState():
              return Center(child: CircularProgressIndicator());
            case ProfileErrorState():
              return ErrorStateWidget(
                serverError: profileState.serverError,
                exception: profileState.exception,
              );
          }
        },
      ),
    );
  }
}
