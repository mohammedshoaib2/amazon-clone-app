import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const CustomButton(
      {super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h),
      // padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 10.h),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: color,
            minimumSize: Size(double.infinity, 50.h),
          ),
          child: Text(
            text,
            style:
                TextStyle(color: color == null ? Colors.white : Colors.black),
          )),
    );
  }
}
