import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/core/functions/validators.dart';
import 'package:movies/core/resources_manager/dialog_utils.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/providers/edit_profile_provider.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.avatarIndex,
  });

  final String name;
  final String phoneNumber;
  final int avatarIndex;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late EditProfileProvider _editProfileProvider;
  late int _selectedAvatarIndex;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  void _updateData() async {
    if (!_formKey.currentState!.validate()) return;
    if (_nameController.text == widget.name &&
        _phoneController.text == widget.phoneNumber.substring(3) &&
        _selectedAvatarIndex == widget.avatarIndex) {
      DialogUtils.showMessageDialog(
        context,
        "No updates where found in email, phone or avatar",
        positiveTitle: 'ok',
      );
    } else {
      String phone = '+20${_phoneController.text}';
      await _editProfileProvider.update(
        context,
        name: _nameController.text,
        phone: phone,
        avatarId: _selectedAvatarIndex,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _editProfileProvider = EditProfileProvider();
    _selectedAvatarIndex = widget.avatarIndex;
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(
      text: widget.phoneNumber.substring(3),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _editProfileProvider.dispose();
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
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: _editProfileProvider)],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Pick Avatar')),
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
                    validator: Validators.nameValidator,
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
                    validator: Validators.phoneValidator,
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
                    onTap: () async {
                      await _editProfileProvider.delete(context);
                    },
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
      ),
    );
  }
}
