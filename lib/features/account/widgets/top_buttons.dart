// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopButtons extends StatelessWidget {
  AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            AccountButton(
                text: 'Logout',
                onTap: () {
                  accountServices.logOut(context: context);
                }),
            AccountButton(text: 'Your Wish List', onTap: () {}),
          ],
        )
      ],
    );
  }
}
