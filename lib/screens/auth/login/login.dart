import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/functions/validators.dart';
import 'package:movies/core/resources_manager/dialog_utils.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_call_for_action_widget.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/data/api_services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisibility = true;

  // int _currentLanguage = 0;

  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void getCashedUserCredentials() async {
    DialogUtils.showLoadingDialog(context, message: 'please wait');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cashedJson = prefs.getString('userCredentials');
    if (!mounted) return;
    DialogUtils.hideDialog(context);
    if (cashedJson != null) {
      var credentialsJson = jsonDecode(cashedJson);
      await ApiServices.loginUser(
        email: credentialsJson['email'],
        password: credentialsJson['password'],
        context: context,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // void _changeLanguage(int newValue) {
  //   setState(() {
  //     _currentLanguage = newValue;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getCashedUserCredentials(),
    );
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: REdgeInsets.all(20),
          children: [
            // Logo
            SizedBox(height: 32.h),
            Center(
              child: Image.asset(
                AssetsManager.logo,
                width: 120.w,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Email Field
            SizedBox(height: 70.h),
            CustomTextFormField(
              controller: _emailController,
              validator: Validators.emailValidator,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.email_rounded),
              labelText: 'Email',
            ),
            SizedBox(height: 20.h),

            // Password Field
            CustomTextFormField(
              controller: _passwordController,
              validator: Validators.passwordValidator,
              keyboardType: TextInputType.text,
              labelText: "Password",
              prefixIcon: Icon(Icons.lock_rounded),
              isPassword: true,
              obscureText: passwordVisibility,
              onVisibilityClick: () {
                setState(() {
                  passwordVisibility = !passwordVisibility;
                });
              },
            ),
            SizedBox(height: 10.h),

            // Forgot Password
            // TextButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, RoutesManager.forgetPassword);
            //   },
            //   style: TextButton.styleFrom(alignment: Alignment.centerRight),
            //   child: Text(
            //     'Forget Password ?',
            //     style: GoogleFonts.roboto(
            //       fontWeight: FontWeight.w400,
            //       color: ColorsManager.yellow,
            //       fontSize: 14.sp,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10.h),

            // Login Button
            SizedBox(height: 70.h),

            CustomButton(
              text: 'Login',
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                ApiServices.loginUser(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context,
                );
              },
            ),
            SizedBox(height: 20.h),

            // Create Account
            CustomCallForActionWidget(
              callForAction: 'Don’t Have Account ? ',
              actionText: 'Create One',
              action: () {
                Navigator.pushNamed(context, RoutesManager.register);
              },
            ),
            // SizedBox(height: 10.h),

            // Divider with OR
            // Row(
            //   children: [
            //     Expanded(
            //       child: Divider(
            //         color: ColorsManager.yellow,
            //         indent: 80.w,
            //         endIndent: 12.w,
            //       ),
            //     ),
            //     Text('OR', style: TextStyle(color: ColorsManager.yellow)),
            //     Expanded(
            //       child: Divider(
            //         color: ColorsManager.yellow,
            //         endIndent: 80.w,
            //         indent: 12.w,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20.h),
            //
            // // Google Login Button
            // LoginWithGoogle(onTap: () {}),
            SizedBox(height: 32.h),

            // Language Toggle
            // Center(
            //   child: LanguageToggleSwitch(
            //     currentLanguage: _currentLanguage,
            //     changeLanguage: _changeLanguage,
            //   ),
            // ),
            // SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
