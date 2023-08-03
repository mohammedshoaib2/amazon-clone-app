import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _productFormKey = GlobalKey<FormState>();
  AdminServices adminServices = AdminServices();

  List<File> images = [];

  List<String> categoryList = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  String _currentDropDownItem = 'Mobiles';

  void productImages() async {
    images = await pickImages();
    setState(() {});
  }

  void sellProduct() {
    if (_productFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          images: images,
          category: _currentDropDownItem,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _productFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              child: Column(
                children: [
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((e) {
                            return Builder(
                              builder: (context) {
                                return Image.file(
                                  e,
                                  fit: BoxFit.contain,
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              viewportFraction: 1, height: 200.h),
                        )
                      : GestureDetector(
                          onTap: productImages,
                          child: DottedBorder(
                              color: Colors.black87,
                              radius: Radius.circular(12.r),
                              borderType: BorderType.RRect,
                              strokeWidth: 2.w,
                              dashPattern: const [10, 4],
                              child: Container(
                                alignment: Alignment.center,
                                height: 150.h,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40.h,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(height: 5.h),
                                    const Text(
                                      'Select Product Images',
                                      style: TextStyle(
                                          color: Colors.black12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )),
                        ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                      hint: 'Product Name', controller: productNameController),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    hint: 'Description',
                    controller: descriptionController,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                      hint: 'Price', controller: priceController),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    hint: 'Quantity',
                    controller: quantityController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      value: _currentDropDownItem,
                      items: categoryList.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentDropDownItem = val!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      text: 'Sell',
                      onTap: () {
                        sellProduct();
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }
}
