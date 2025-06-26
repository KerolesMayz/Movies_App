import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors_manager/colors_Manager.dart';
import 'custom_button.dart';
import 'image_gradient_container.dart';

class CustomOnboardingPage extends StatefulWidget {
  const CustomOnboardingPage({
    super.key,
    required this.title,
    required this.imagePath,
    this.body,
    required this.bottomGradientColor,
    this.onNext,
    this.onBack,
    this.isLastPage = false,
  });

  final String title;
  final String? body;
  final String imagePath;
  final Color bottomGradientColor;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool isLastPage;

  @override
  State<CustomOnboardingPage> createState() => _CustomOnboardingPageState();
}

class _CustomOnboardingPageState extends State<CustomOnboardingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        isDismissible: false,
        context: context,
        enableDrag: false,
        barrierColor: ColorsManager.transparent,
        backgroundColor: ColorsManager.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: REdgeInsets.only(
                left: 16,
                right: 16,
                top: 26,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 24.h),
                  if (widget.body != null)
                    Text(
                      widget.body!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: widget.isLastPage ? 'Finish' : 'Next',
                    onTap: widget.onNext,
                  ),
                  SizedBox(height: 16.h),
                  if (widget.onBack != null)
                    CustomButton(
                      backgroundColor: ColorsManager.black,
                      foregroundColor: ColorsManager.yellow,
                      text: 'Back',
                      onTap: widget.onBack,
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ImageGradientContainer(
      imagePath: widget.imagePath,
      bottomGradientColor: widget.bottomGradientColor,
    );
  }
}
