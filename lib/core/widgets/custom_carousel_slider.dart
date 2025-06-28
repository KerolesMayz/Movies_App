import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    required this.items,
    this.onPageChanged,
  });

  final void Function(int, CarouselPageChangedReason)? onPageChanged;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 350.h,
        onPageChanged: onPageChanged,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.55,
        enlargeFactor: 0.27,
      ),
    );
  }
}
