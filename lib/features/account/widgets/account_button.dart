import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: 45.h,
          margin: EdgeInsets.symmetric(horizontal: 10.h),
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.03),
            border: Border.all(
                color: GlobalVariables.greyBackgroundCOlor, width: 1),
            borderRadius: BorderRadius.circular(200.r),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w300),
          )),
    ));
  }
}
