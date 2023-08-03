// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void decreseProduct(
      {required BuildContext context, required String id}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response response = await http
          .delete(Uri.parse('$uri/api/remove-from-cart/$id'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      });

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
