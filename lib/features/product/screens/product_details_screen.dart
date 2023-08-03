import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/product/services/product_services.dart';
import 'package:amazon_clone/features/search/widgets/rating_bar.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../search/screens/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double myRating = 0.0;
  double avgRating = 0.0;

  ProductServices productServices = ProductServices();

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {

    // });
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating = totalRating + widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  height: 42.h,
                  margin: EdgeInsets.only(left: 15.w),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7.r),
                    child: TextFormField(
                      onFieldSubmitted: (search) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SearchScreen(searchQueary: search);
                            },
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        hintText: 'Search in Amazon.in',
                        fillColor: GlobalVariables.backgroundColor,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.r))),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              const Icon(
                Icons.mic,
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  CustomRatingBar(rating: avgRating),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                  height: 200.h,
                  child: CarouselSlider(
                      items: widget.product.images
                          .map((e) => Image.network(
                                e,
                                fit: BoxFit.contain,
                              ))
                          .toList(),
                      options:
                          CarouselOptions(viewportFraction: 1, height: 200.h))),
              const Divider(
                thickness: 5,
                color: Colors.black12,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Deal Price: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                TextSpan(
                  text: '\$${widget.product.price}',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.sp,
                  ),
                ),
              ])),
              SizedBox(
                height: 20.h,
              ),
              Text(
                widget.product.description,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              const Divider(
                thickness: 5,
                color: Colors.black12,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(text: 'Buy Now', onTap: () {}),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: 'Add to Cart',
                onTap: () {
                  productServices.addToCart(
                      context: context, product: widget.product);
                },
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Rate the Product',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
              ),
              RatingBar.builder(
                  minRating: 1,
                  initialRating: myRating,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    );
                  },
                  onRatingUpdate: (val) {
                    productServices.rateProduct(
                        context: context,
                        productId: widget.product.id!,
                        rating: val);
                  })
            ],
          ),
        )
      ]),
    );
  }
}
