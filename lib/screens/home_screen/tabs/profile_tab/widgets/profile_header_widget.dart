import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/data/models/login_response/Login_response.dart';
import 'package:movies/screens/update_profile/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/colors_manager/colors_Manager.dart';
import '../../../../../core/resources_manager/dialog_utils.dart';
import '../../../../../core/routes_manager/routes_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../data/models/profile_response/profile_data.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.watchListCount,
    required this.historyCount,
    required this.avatarIndex,
  });

  final int avatarIndex;
  final String name;
  final String phone;
  final String watchListCount;
  final int historyCount;

  void _logout(BuildContext context) {
    DialogUtils.showMessageDialog(
      context,
      "Sure you want to logout?",
      positiveTitle: 'Yes',
      positiveAction: () async {
        DialogUtils.showLoadingDialog(context, message: 'plz wait');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('userCredentials');
        ProfileData.userProfile = null;
        LoginResponse.userToken = null;
        DialogUtils.hideDialog(context);
        DialogUtils.showMessageDialog(
          context,
          'Loged out Successfully',
          negativeTitle: 'Register',
          negativeAction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.register,
            (_) => false,
          ),
          positiveTitle: 'Login',
          positiveAction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.login,
            (_) => false,
          ),
        );
      },
      negativeTitle: 'No',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.mediumBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 26.h),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              ConstantsManager.avatarList[avatarIndex],
                            ),
                            radius: 60.r,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            watchListCount,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Watch List',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(fontSize: 24.sp),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            historyCount.toString(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'History',
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(fontSize: 24.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Edit Profile',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UpdateProfile(
                              name: name,
                              phoneNumber: phone,
                              avatarIndex: avatarIndex,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomButton(
                      text: 'Exit',
                      onTap: () {
                        _logout(context);
                      },
                      borderColor: Colors.red,
                      backgroundColor: Colors.red,
                      foregroundColor: ColorsManager.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Exit'),
                          SizedBox(width: 10),
                          Icon(Icons.logout_rounded, size: 20.r),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
