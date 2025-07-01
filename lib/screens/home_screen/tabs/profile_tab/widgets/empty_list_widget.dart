import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: Theme.of(context).bottomAppBarTheme.height! + 100),
        Lottie.asset(
          'assets/animations/popcorn.json',
          height: 124.h,
          fit: BoxFit.fitHeight,
          reverse: true,
        ),
        SizedBox(height: Theme.of(context).bottomAppBarTheme.height),
      ],
    );
  }
}
