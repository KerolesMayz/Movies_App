import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  int languageValue = 0;
  int selectedAvatar = 1;

  final List<String> avatarImages = [
    'assets/images/avatars/avatar0.png',
    'assets/images/avatars/avatar1.png',
    'assets/images/avatars/avatar2.png',
  ];


  void _changeLanguage(int newValue) {
    setState(() {
      languageValue = newValue;
    });

    // TODO: Implement localization logic
    print(newValue == 0 ? 'English selected' : 'Arabic selected');
  }

  void _selectAvatar(int index) {
    setState(() {
      selectedAvatar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: ColorsManager.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Picker
            Center(
              child: Column(
                children: [
                  CarouselSlider.builder(
                    // carouselController: ,
                    itemCount: avatarImages.length,
                    options: CarouselOptions(
                      height: 100.h,
                      enlargeCenterPage: true,
                      viewportFraction: 0.35,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedAvatar = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final isSelected = selectedAvatar == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedAvatar = index),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? ColorsManager.yellow
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(4.w),
                          child: CircleAvatar(
                            radius: isSelected ? 48.r : 40.r,
                            backgroundImage: AssetImage(avatarImages[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Name Field
            _buildInputField(
              label: "Name",
              icon: Icons.person,
            ),
            SizedBox(height: 16.h),

            // Email Field
            _buildInputField(
              label: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: 16.h),

            // Password
            _buildInputField(
              label: "Password",
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 16.h),

            // Confirm Password
            _buildInputField(
              label: "Confirm Password",
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 16.h),

            // Phone Number
            _buildInputField(
              label: "Phone Number",
              icon: Icons.phone,
            ),
            SizedBox(height: 24.h),

            // Create Account Button
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
                  'Create Account',
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account ? ",
                  style: TextStyle(color: ColorsManager.white),
                ),
                GestureDetector(
                  onTap: () {}, // TODO: Navigate to Login
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: ColorsManager.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // Language Toggle
            Center(
              child: AnimatedToggleSwitch<int>.rolling(
                current: languageValue,
                values: const [0, 1],
                onChanged: _changeLanguage,
                iconBuilder: (val, isSelected) {
                  return val == 0
                      ? Image.asset('assets/images/flags/lr.png',
                      width: 24.w, height: 24.h)
                      : Image.asset('assets/images/flags/eg.png',
                      width: 24.w, height: 24.h);
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

  Widget _buildInputField({
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.lightBlack,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: ColorsManager.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: ColorsManager.white),
          prefixIcon: Icon(icon, color: ColorsManager.white),
          suffixIcon: isPassword
              ? Icon(Icons.visibility_off, color: ColorsManager.white)
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        ),
      ),
    );
  }
}
