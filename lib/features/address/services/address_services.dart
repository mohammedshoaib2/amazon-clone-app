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

class AddressServices {
  void addAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(response.body)['address']);

            userProvider.setUserWithModel(user);
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required double totalPrice,
      required String address}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'cart': userProvider.user.cart,
            'totalPrice': totalPrice,
            'address': address,
          },
        ),
      );
      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(cart: []);

            userProvider.setUserWithModel(user);
            showSnackbar(context: context, text: 'Order Placed');
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }
}
