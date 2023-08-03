import 'package:amazon_clone/features/product/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/widgets/rating_bar.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SerchedProduct extends StatefulWidget {
  final Product product;

  const SerchedProduct({super.key, required this.product});

  @override
  State<SerchedProduct> createState() => _SerchedProductState();
}

class _SerchedProductState extends State<SerchedProduct> {
  double avgRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating = totalRating + widget.product.rating![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return ProductDetailsScreen(product: widget.product);
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h, left: 20.w),
        height: 170.h,
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                widget.product.images.first,
                height: 160.h,
                width: 160.w,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 20.h),
                          child: Text(
                            widget.product.name,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 22.sp,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomRatingBar(rating: avgRating),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '\$${widget.product.price}',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Eligible for FREE Shipping',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'In Stock',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.teal,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
