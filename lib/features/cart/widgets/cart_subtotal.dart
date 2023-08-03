import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    double total = 0;
    for (var cart in user.cart) {
      int price = cart['product']['price'];
      int quantitiy = cart['quantity'];
      total = total + (price * quantitiy);
    }

    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Row(
        children: [
          Text(
            "Sub Total: ",
            style: TextStyle(
              fontSize: 20.sp,
            ),
          ),
          Text(
            '\$${total.toString()}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
