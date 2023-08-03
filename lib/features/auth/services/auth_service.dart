// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          token: '',
          cart: [],
          type: '');

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(
                context: context, text: 'Account Has been Created, Login Now');
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    http.Response response = await http.post(Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        });

    httpRequestHandler(
      response: response,
      context: context,
      onSuccess: () async {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();

        preferences.setString(
            "x-auth-token", jsonDecode(response.body)['token']);

        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const HomeScreen();
        }));
      },
    );
  }

  Future getUserData({required BuildContext context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('x-auth-token');
      if (token == null) {
        preferences.setString('x-auth-token', '');
        return;
      }

      http.Response tokenRes = await http
          .post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json',
        'x-auth-token': token,
      });

      dynamic isTokenValid = jsonDecode(tokenRes.body);

      if (isTokenValid) {
        http.Response response =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': token,
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(response.body);
      }
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }
}
