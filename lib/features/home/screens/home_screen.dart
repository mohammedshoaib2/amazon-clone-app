import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/home/widgets/carousel_image.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/global_variable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeServices homeServices = HomeServices();
  Product? product;

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfTheDayProduct(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: ListView(
        children: [
          const Row(
            children: [
              AddressBox(),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const TopCategories(),
          const CarouselImage(),
          SizedBox(
            height: 10.h,
          ),
          product != null
              ? product!.name.isEmpty
                  ? const SizedBox()
                  : DealOfTheDay(product: product!)
              : const Text('Loading'),
        ],
      ),
    );
  }
}
