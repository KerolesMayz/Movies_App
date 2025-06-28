import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int selectedAvatarIndex = 0;
  final TextEditingController nameController =
  TextEditingController(text: 'John Safwat');
  final TextEditingController phoneController =
  TextEditingController(text: '01200000000');

  final List<String> avatarList = List.generate(
    9,
        (index) => 'assets/images/avatars/avatar$index.png',
  );

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.mediumBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: avatarList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedAvatarIndex = index;
                });
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.lightBlack,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: selectedAvatarIndex == index
                        ? ColorsManager.yellow
                        : Colors.transparent,
                    width: 2.w,
                  ),
                ),
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  avatarList[index],
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
      backgroundColor: ColorsManager.black,
      appBar: AppBar(
        title: const Text('Pick Avatar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Center(
                      child: GestureDetector(
                        onTap: _showAvatarPicker,
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundImage:
                          AssetImage(avatarList[selectedAvatarIndex]),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Name
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.lightBlack,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(color: ColorsManager.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: ColorsManager.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Phone
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.lightBlack,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: phoneController,
                        style: TextStyle(color: ColorsManager.white),
                        decoration: InputDecoration(
                          prefixIcon:
                          Icon(Icons.phone, color: ColorsManager.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Reset password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            color: ColorsManager.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons aligned to bottom
            Column(
              children: [
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Delete logic
                    },
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      // TODO: Update logic
                    },
                    child: Text(
                      'Update Data',
                      style: TextStyle(
                        color: ColorsManager.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

}