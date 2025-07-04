import 'package:flutter/material.dart';

import '../core/resources_manager/dialog_utils.dart';
import '../core/routes_manager/routes_manager.dart';
import '../data/api_services/api_services.dart';
import '../data/models/register_response/Register_response.dart';
import '../data/result/result.dart';

class RegisterProvider extends ChangeNotifier {
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required int avatarId,
    required BuildContext context,
  }) async {
    DialogUtils.showLoadingDialog(
      context,
      message: "please wait",
      dismissible: false,
    );
    Result<RegisterResponse> response = await ApiServices.registerUser(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
      avatarId: avatarId,
      context: context,
    );
    DialogUtils.hideDialog(context);
    switch (response) {
      case Success<RegisterResponse>():
        DialogUtils.showMessageDialog(
          context,
          'Signedup Successfully',
          positiveTitle: 'login',
          negativeTitle: 'ok',
          positiveAction: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.login,
              (route) => false,
            );
          },
        );
      case ServerError<RegisterResponse>():
        DialogUtils.showMessageDialog(
          context,
          response.message.toString(),
          positiveTitle: 'ok',
        );
      case GeneralException<RegisterResponse>():
        DialogUtils.showMessageDialog(
          context,
          'Connection Error',
          positiveTitle: 'ok',
        );
    }
  }
}
