import 'package:flutter/material.dart';
import 'package:movies/data/api_services/api_services.dart';
import 'package:movies/data/models/general_response/general_response.dart';
import 'package:movies/data/models/login_response/Login_response.dart';
import 'package:movies/data/result/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/resources_manager/dialog_utils.dart';
import '../core/routes_manager/routes_manager.dart';

class EditProfileProvider extends ChangeNotifier {
  Future<void> delete(BuildContext context) async {
    DialogUtils.showMessageDialog(
      context,
      "Sure you want to Delete Account ?",
      positiveTitle: 'Yes',
      positiveAction: () async {
        DialogUtils.showLoadingDialog(context, message: 'please wait');
        var result = await ApiServices.deleteUser();
        switch (result) {
          case Success<GeneralResponse>():
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('userCredentials');
            LoginResponse.userToken = null;
            DialogUtils.hideDialog(context);
            DialogUtils.showMessageDialog(
              context,
              'Account Deleted Successfully',
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
          case ServerError<GeneralResponse>():
            DialogUtils.hideDialog(context);
            DialogUtils.showMessageDialog(
              context,
              result.message,
              negativeTitle: 'ok',
            );
          case GeneralException<GeneralResponse>():
            DialogUtils.hideDialog(context);
            DialogUtils.showMessageDialog(
              context,
              result.exception.toString(),
              negativeTitle: 'ok',
            );
        }
      },
      negativeTitle: 'No',
    );
  }

  Future<void> update(BuildContext context, {
    required String name,
    required String phone,
    required int avatarId,
  }) async {

    DialogUtils.showMessageDialog(
      context,
      "Sure you want to Update Account ?",
      positiveTitle: 'Yes',
      positiveAction: () async {
        DialogUtils.showLoadingDialog(context, message: 'please wait');

        var result = await ApiServices.updateUser(
          name: name,
          phone: phone,
          avatarId: avatarId,
        );

        DialogUtils.hideDialog(context);

        switch (result) {
          case Success<GeneralResponse>():
            DialogUtils.showMessageDialog(
              context,
              'Account Updated Successfully',
              positiveTitle: 'ok',
            );
          case ServerError<GeneralResponse>():
            DialogUtils.showMessageDialog(
              context,
              result.message,
              negativeTitle: 'ok',
            );
          case GeneralException<GeneralResponse>():
            DialogUtils.showMessageDialog(
              context,
              result.exception.toString(),
              negativeTitle: 'ok',
            );
        }
      },
      negativeTitle: 'No',
    );
  }
}
