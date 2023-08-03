// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    List<Product> listOfCategoryProducts = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/api/products?category=$category'));
      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            List listOfProduct = jsonDecode(response.body);

            listOfCategoryProducts = listOfProduct
                .map((e) => Product.fromJson(jsonEncode(e)))
                .toList();
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
    return listOfCategoryProducts;
  }

  Future<Product> fetchDealOfTheDayProduct(
      {required BuildContext context}) async {
    Product product = Product(
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
    );

    try {
      http.Response response =
          await http.get(Uri.parse('$uri/api/deal-of-the-day'), headers: {
        'x-auth-token':
            Provider.of<UserProvider>(context, listen: false).user.token,
      });

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            product = Product.fromJson(response.body);
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }

    return product;
  }
}
