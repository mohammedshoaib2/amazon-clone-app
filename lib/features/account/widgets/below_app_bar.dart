import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      padding: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
      ),
      decoration: const BoxDecoration(
        // color: Colors.red,
        gradient: GlobalVariables.appBarGradient,
      ),
      child: RichText(
        text: TextSpan(
            text: 'Hello, ',
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w300),
            children: [
              TextSpan(
                  text: Provider.of<UserProvider>(context).user.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  )),
            ]),
      ),
    );
  }
}
