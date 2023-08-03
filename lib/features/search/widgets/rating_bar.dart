import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;

  const CustomRatingBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        itemSize: 20.w,
        rating: rating,
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star,
            color: GlobalVariables.secondaryColor,
          );
        });
  }
}
