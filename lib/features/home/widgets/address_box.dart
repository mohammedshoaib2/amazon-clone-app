import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [
            0.5,
            1.0,
          ],
        ),
      ),
      padding: EdgeInsets.only(
        left: 10.w,
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 22.h,
          ),
          Expanded(
            child: Text(
              'Delivery to ${user.name} - ${user.address}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 10.w, top: 2.h),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
