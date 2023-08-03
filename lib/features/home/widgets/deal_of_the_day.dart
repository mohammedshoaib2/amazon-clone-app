import 'package:amazon_clone/features/product/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealOfTheDay extends StatelessWidget {
  final Product product;

  const DealOfTheDay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailsScreen(product: product);
        }));
      },
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                'Deal of the day',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Image.network(
              product.images.first,
              height: 235.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: product.images.map((image) {
                      return Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Image.network(
                          image,
                          height: 100.h,
                          width: 100.w,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h).copyWith(left: 10.w),
                  child: Text(
                    'See all deals',
                    style: TextStyle(
                      color: Colors.cyan[800],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
