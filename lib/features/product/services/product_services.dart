// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductServices {
  void rateProduct({
    required BuildContext context,
    required String productId,
    required double rating,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token,
        },
        body: jsonEncode({
          "productId": productId,
          "rating": rating,
        }),
      );

      httpRequestHandler(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackbar(
        context: context,
        text: e.toString(),
      );
    }
  }

  void addToCart(
      {required BuildContext context, required Product product}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'productId': product.id,
        }),
      );

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              cart: jsonDecode(response.body)['cart'],
            );

            userProvider.setUserWithModel(user);
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }
}
