import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProduct extends StatelessWidget {
  final String image;

  const SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Image.network(
          image,
          height: 180.h,
          fit: BoxFit.fitHeight,
        ));
  }
}
