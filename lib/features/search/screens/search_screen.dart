import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  final String searchQueary;

  const SearchScreen({super.key, required this.searchQueary});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchServices searchServices = SearchServices();
  List<Product>? products;

  void fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, search: widget.searchQueary);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchSearchedProducts();
    });
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
                      initialValue: widget.searchQueary,
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
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return SerchedProduct(
                          product: products![index],
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
