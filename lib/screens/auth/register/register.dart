import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/core/functions/validators.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_call_for_action_widget.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/core/widgets/language_toggle_switch.dart';
import 'package:movies/data/api_services/api_services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int languageValue = 0;
  int selectedAvatar = 0;
  bool passwordVisibility = true;
  bool confirmPasswordVisibility = true;
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CarouselSliderController controller;

  void onRegisterTap() {
    if (!_formKey.currentState!.validate()) return;
    String phone = '+20${_phoneController.text}';
    ApiServices.registerUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      phoneNumber: phone,
      avatarId: selectedAvatar,
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    controller = CarouselSliderController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  String? _confirmPasswordValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please enter your password confirmation';
    } else if (input.trim().length < 8) {
      return 'Please enter password larger that 7';
    } else if (_passwordController.text.trim() != input.trim()) {
      return 'please enter the same password';
    }
    return null;
  }

  void _changeLanguage(int newValue) {
    setState(() {
      languageValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            // Avatar Picker
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: ConstantsManager.avatarList.length,
              options: CarouselOptions(
                height: 100.h,
                enlargeCenterPage: true,
                viewportFraction: 0.35,
                onPageChanged: (index, _) {
                  setState(() {
                    selectedAvatar = index;
                  });
                },
              ),
              itemBuilder: (context, index, _) {
                bool isSelected = selectedAvatar == index;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedAvatar = index;
                      controller.animateToPage(selectedAvatar);
                    });
                  },
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
                      backgroundImage: AssetImage(
                        ConstantsManager.avatarList[index],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30.h),

            // Name Field
            CustomTextFormField(
              keyboardType: TextInputType.name,
              controller: _nameController,
              validator: Validators.nameValidator,
              prefixIcon: Icon(Icons.person),
              labelText: 'Name',
            ),
            SizedBox(height: 16.h),

            // Email Field
            CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: Validators.emailValidator,
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 16.h),

            // Password
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              validator: Validators.passwordValidator,
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
            SizedBox(height: 16.h),

            // Confirm Password
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _confirmPasswordController,
              validator: _confirmPasswordValidator,
              labelText: "Confirm Password",
              prefixIcon: Icon(Icons.lock_rounded),
              isPassword: true,
              obscureText: confirmPasswordVisibility,
              onVisibilityClick: () {
                setState(() {
                  confirmPasswordVisibility = !confirmPasswordVisibility;
                });
              },
            ),
            SizedBox(height: 16.h),

            // Phone Number
            CustomTextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              prefixText: '+20 ',
              validator: Validators.phoneValidator,
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              labelText: "Phone Number",
              prefixIcon: Icon(Icons.phone_rounded),
            ),
            SizedBox(height: 24.h),

            // Create Account Button
            CustomButton(text: 'Create Account', onTap: onRegisterTap),
            SizedBox(height: 20.h),

            // Already have account
            CustomCallForActionWidget(
              callForAction: "Already Have Account ? ",
              actionText: 'Login',
              action: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesManager.login,
                  (_) => false,
                );
              },
            ),
            SizedBox(height: 30.h),

            // Language Toggle
            Center(
              child: LanguageToggleSwitch(
                currentLanguage: languageValue,
                changeLanguage: _changeLanguage,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
