// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProduct(
      {required BuildContext context, required String search}) async {
    List<Product> listOfSearchedProducts = [];

    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/products/search/$search'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token':
            Provider.of<UserProvider>(context, listen: false).user.token,
      });

      httpRequestHandler(
        response: response,
        context: context,
        onSuccess: () {
          List result = jsonDecode(response.body);

          listOfSearchedProducts = result
              .map((e) => Product.fromJson(
                    jsonEncode(e),
                  ))
              .toList();
        },
      );
    } catch (e) {
      showSnackbar(
        context: context,
        text: e.toString(),
      );
    }

    return listOfSearchedProducts;
  }
}
