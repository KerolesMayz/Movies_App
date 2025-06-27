import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int value = 0;
  void _changeLanguage(int newValue) {
    setState(() {
      value = newValue;
    });

    // TODO: Replace this with your actual localization change logic
    if (newValue == 0) {
      print('Language changed to English');
      // context.setLocale(Locale('en')); // if using easy_localization
    } else {
      print('Language changed to Arabic');
      // context.setLocale(Locale('ar')); // if using easy_localization
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            // Logo
            Center(
              child: Image.asset("assets/images/splash/logo.png", width: 200.w,)
            ),
            // SizedBox(height: 70.h),

            // Email Field
            Container(
              decoration: BoxDecoration(
                color: ColorsManager.lightBlack,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                style: TextStyle(color: ColorsManager.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: ColorsManager.white),
                  prefixIcon: Icon(Icons.email, color: ColorsManager.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Password Field
            Container(
              decoration: BoxDecoration(
                color: ColorsManager.lightBlack,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: ColorsManager.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: ColorsManager.white),
                  prefixIcon: Icon(Icons.lock, color: ColorsManager.white),
                  suffixIcon: Icon(Icons.visibility_off, color: ColorsManager.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forget Password ?',
                  style: TextStyle(color: ColorsManager.yellow),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Create Account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have Account ? ",
                  style: TextStyle(color: ColorsManager.white),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Create One",
                    style: TextStyle(
                      color: ColorsManager.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // Divider with OR
            Row(
              children: [
                Expanded(
                  child: Divider(color: ColorsManager.white),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    'OR',
                    style: TextStyle(color: ColorsManager.white),
                  ),
                ),
                Expanded(
                  child: Divider(color: ColorsManager.white),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Google Login Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.g_mobiledata_outlined, size: 28.sp, color: ColorsManager.black),
                label: Text(
                  'Login With Google',
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),

            // SizedBox(height: 5.h),

            // Language Toggle
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
              child: AnimatedToggleSwitch<int>.rolling(
                current: value,
                values: const [0, 1],
                  // TODO: Handle language change logic
                onChanged: _changeLanguage,
                iconBuilder: (val, isSelected) {
                  return val == 0
                      ? Image.asset('assets/images/flags/lr.png', width: 24.w, height: 24.h)
                      : Image.asset('assets/images/flags/eg.png', width: 24.w, height: 24.h);
                },
                style: ToggleStyle(

                  backgroundColor: Colors.transparent,
                  indicatorColor: ColorsManager.yellow,
                  borderColor: ColorsManager.yellow,
                  borderRadius: BorderRadius.circular(30.r),
                  indicatorBorderRadius: BorderRadius.circular(30.r),
                ),
                spacing: 15.w,
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
