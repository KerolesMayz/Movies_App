import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/extension/context_extension.dart';
import 'package:movies/core/functions/validators.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _emailController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: [
            Image.asset(
              "assets/images/forget_password.png",
              width: context.width,
            ),
            SizedBox(height: 24.h),

            CustomTextFormField(
              controller: _emailController,
              validator: Validators.emailValidator,
              keyboardType: TextInputType.emailAddress,
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 24.h),

            /// Verify Email Button
            CustomButton(
              text: 'Verify Email',
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
