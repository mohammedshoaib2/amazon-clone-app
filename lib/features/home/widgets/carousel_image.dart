import 'package:amazon_clone/constants/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return ClipRRect(
            child: Image.network(
          i,
          fit: BoxFit.cover,
          width: double.infinity,
        ));
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200.h),
    );
  }
}
