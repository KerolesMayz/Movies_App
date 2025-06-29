import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/core/resources_manager/dialog_utils.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int _selectedAvatarIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String initName = 'John Safwat';
  String initPhone = '+201111111111'.substring(3);

  String? _nameValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please inter your name';
    } else if (input.trim().length < 3) {
      return 'please enter a name from 3 characters';
    }
    return null;
  }

  String? _phoneValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please inter your phone number';
    } else if (input.trim().length < 10) {
      return 'please enter a valid phone number';
    }
    return null;
  }

  void _updateData() {
    if (!_formKey.currentState!.validate()) return;
    if (initName == _nameController.text &&
        initPhone == _phoneController.text) {
      DialogUtils.showMessageDialog(
        context,
        "No updates where found in email or phone",
        positiveTitle: 'ok',
      );
    } else {
      DialogUtils.showMessageDialog(
        context,
        "Finish and update Data ?",
        positiveTitle: 'Yes',
        positiveAction: () {
          DialogUtils.showLoadingDialog(context, message: 'plz wait');
          DialogUtils.hideDialog(context);
          DialogUtils.showMessageDialog(
            context,
            'Data Updated Successfully',
            positiveTitle: 'ok',
          );
        },
        negativeTitle: 'No',
      );
    }
  }

  void _deleteAccount() {
    DialogUtils.showMessageDialog(
      context,
      "Sure you want to Delete Account ?",
      positiveTitle: 'Yes',
      positiveAction: () async {
        DialogUtils.showLoadingDialog(context, message: 'plz wait');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('userCredentials');
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
      },
      negativeTitle: 'No',
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: initName);
    _phoneController = TextEditingController(text: initPhone);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: ConstantsManager.avatarList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedAvatarIndex = index;
                });
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedAvatarIndex == index
                      ? ColorsManager.yellow.withValues(alpha: 0.56)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: ColorsManager.yellow, width: 1.w),
                ),
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  ConstantsManager.avatarList[index],
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Pick Avatar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 36.h),
                Center(
                  child: InkWell(
                    onTap: _showAvatarPicker,
                    child: CircleAvatar(
                      radius: 75.r,
                      backgroundImage: AssetImage(
                        ConstantsManager.avatarList[_selectedAvatarIndex],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36.h),

                // Name
                CustomTextFormField(
                  controller: _nameController,
                  validator: _nameValidator,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 20.h),

                // Phone
                CustomTextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  prefixText: '+20 ',
                  validator: _phoneValidator,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  prefixIcon: Icon(Icons.phone_rounded),
                ),
                SizedBox(height: 30.h),

                // Reset password
                Text(
                  "Reset Password",
                  style: Theme.of(context).textTheme.displayMedium,
                ),

                Spacer(),

                CustomButton(
                  text: 'Delete Account',
                  onTap: _deleteAccount,
                  backgroundColor: Colors.red,
                  foregroundColor: ColorsManager.white,
                  borderColor: Colors.red,
                ),
                SizedBox(height: 20.h),

                CustomButton(text: 'Update Data', onTap: _updateData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
