import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: ColorsManager.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/forget_password.png",
                width: 300.w,
              ),
            ),

            SizedBox(height: 40.h),

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

            SizedBox(height: 30.h),

            // Verify Email Button
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
                onPressed: () {
                  // TODO: Add password reset logic
                },
                child: Text(
                  'Verify Email',
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
