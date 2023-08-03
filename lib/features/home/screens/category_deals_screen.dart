import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;

  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  HomeServices homeServices = HomeServices();
  List<Product>? listOfCategoryProducts;
  void fetchCategoryProducts() async {
    listOfCategoryProducts = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            ),
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          )),
      body: listOfCategoryProducts == null
          ? const Loader()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keep Shopping for ${widget.category}',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 170.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // itemCount: 10,
                      itemCount: listOfCategoryProducts!.length,
                      itemBuilder: (context, index) {
                        Product product = listOfCategoryProducts![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (contex) {
                                  return ProductDetailsScreen(product: product);
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 150.h,
                            margin: EdgeInsets.only(top: 0.5.h, right: 10.w),
                            width:
                                (MediaQuery.of(context).size.width / 2) - 20.w,
                            child: Column(
                              children: [
                                Expanded(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.w,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Image.network(
                                        product.images.first,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.w, top: 0.5.h, right: 10.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.name,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
