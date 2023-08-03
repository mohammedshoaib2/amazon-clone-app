// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    List<Order> listOfOrders = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/api/getOrders'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token':
            Provider.of<UserProvider>(context, listen: false).user.token,
      });

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            List orders = jsonDecode(response.body);
            listOfOrders =
                orders.map((e) => Order.fromJson(jsonEncode(e))).toList();
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }

    return listOfOrders;
  }

  void logOut({required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('x-auth-token', '');
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) {
      return const AuthScreen();
    }), (route) => false);
  }
}
