import 'package:flutter/material.dart';
import 'package:movies/core/widgets/error_state_widget.dart';
import 'package:movies/providers/profile_provider.dart';
import 'package:movies/providers/states/history_state.dart';
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
  int _currentTab = 0;
  bool _historyNotSelected = true;

  void _loadProfile() async {
    await _profileProvider.getProfile();
    await _profileProvider.getFavourites();
    // await _profileProvider.getHistory();
  }

  @override
  void initState() {
    super.initState();
    _profileProvider = ProfileProvider();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>.value(
      value: _profileProvider,
      child: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          var profileState = provider.profileState;
          switch (profileState) {
            case ProfileSuccessState():
              return Consumer<ProfileProvider>(
                builder: (context, favProvider, _) {
                  FavouritesState favState = favProvider.favouritesState;
                  switch (favState) {
                    case FavouritesSuccessState():
                      return Column(
                        children: [
                          Visibility(
                            visible: _historyNotSelected,
                            child: ChangeNotifierProvider<
                                ProfileProvider>.value(
                              value: _profileProvider,
                              child: ProfileHeaderWidget(
                                name: ProfileData.userProfile!.name!,
                                phone: ProfileData.userProfile!.phone!,
                                watchListCount: favState.data.length.toString(),
                                historyCount: _profileProvider.historyState is HistorySuccessState ? (_profileProvider.historyState as HistorySuccessState).data.length : 0,
                                avatarIndex: int.parse(
                                  ProfileData.userProfile!.avaterId.toString(),
                                ),
                              ),
                            ),
                          ),
                          ProfileTabBar(
                            onTap: (index) {
                              setState(() {
                                _currentTab = index;
                                _historyNotSelected = _currentTab == 0;

                                if (_currentTab == 1) {
                                  final userId = ProfileData.userProfile!.id.toString();
                                  _profileProvider.getHistory(userId); // ← Add this line!
                                }
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
                            Expanded(
                              child: Consumer<ProfileProvider>(
                                builder: (context, provider, _) {
                                  var historyState = provider.historyState;
                                  switch (historyState) {
                                    case HistorySuccessState():
                                      return historyState.data.isNotEmpty
                                          ? ProfileGrid(favMovies: historyState.data)
                                          : EmptyListWidget();
                                    case HistoryLoadingState():
                                      return Center(child: CircularProgressIndicator());
                                    case HistoryErrorState():
                                      return ErrorStateWidget(exception: historyState.exception);
                                  }
                                },
                              ),
                            )
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
