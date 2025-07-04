import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:movies/data/api_services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/resources_manager/dialog_utils.dart';
import '../core/routes_manager/routes_manager.dart';
import '../data/models/login_response/Login_response.dart';
import '../data/result/result.dart';

class LoginProvider extends ChangeNotifier {
  void getCashedUserCredentials(BuildContext context) async {
    DialogUtils.showLoadingDialog(context, message: 'please wait');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cashedJson = prefs.getString('userCredentials');
    DialogUtils.hideDialog(context);
    if (cashedJson != null) {
      var credentialsJson = jsonDecode(cashedJson);
      await login(
        email: credentialsJson['email'],
        password: credentialsJson['password'],
        context: context,
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    DialogUtils.showLoadingDialog(
      context,
      message: "please wait",
      dismissible: false,
    );
    Result<LoginResponse> result = await ApiServices.loginUser(
      email: email,
      password: password,
      context: context,
    );
    switch (result) {
      case Success<LoginResponse>():
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'userCredentials',
          jsonEncode({'email': email, 'password': password}),
        );
        LoginResponse.userToken = result.data.data;
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.homeScreen,
          (_) => false,
        );

      case ServerError<LoginResponse>():
        DialogUtils.hideDialog(context);
        DialogUtils.showMessageDialog(
          context,
          'Wrong Email or Password',
          positiveTitle: 'ok',
        );
      case GeneralException<LoginResponse>():
        DialogUtils.hideDialog(context);
        DialogUtils.showMessageDialog(
          context,
          'Connection Error',
          positiveTitle: 'ok',
        );
    }
  }
}
