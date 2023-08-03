// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/sale.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProducts({
    required String name,
    required String description,
    required double price,
    required double quantity,
    required List<File> images,
    required String category,
    required BuildContext context,
  }) async {
    final cloudinary = CloudinaryPublic('dripgidvj', 'groisn4r');
    List<String> imageUrls = [];
    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse cloudinaryResponse =
          await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path));
      imageUrls.add(cloudinaryResponse.secureUrl);
    }
    Product product = Product(
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      category: category,
      images: imageUrls,
    );

    http.Response response = await http.post(
      Uri.parse('$uri/admin/add-product'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-auth-token':
            Provider.of<UserProvider>(context, listen: false).user.token,
      },
      body: product.toJson(),
    );

    httpRequestHandler(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackbar(context: context, text: 'Product Added');
        });
  }

  Future<List<Product>> fetchAllProducts(
      {required BuildContext context}) async {
    List<Product> listOfProducts = [];
    try {
      http.Response response = await http.get(
          Uri.parse(
            '$uri/admin/get-products',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': Provider.of<UserProvider>(context, listen: false)
                .user
                .token
                .toString(),
          });

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            List result = jsonDecode(response.body);
            listOfProducts =
                result.map((e) => Product.fromJson(jsonEncode(e))).toList();
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
    return listOfProducts;
  }

  Future deleteProduct(
      {required BuildContext context,
      required String id,
      required VoidCallback refreshScreen}) async {
    http.Response response = await http
        .post(Uri.parse('$uri/admin/delete-product'), headers: <String, String>{
      'Content-Type': 'application/json',
      'x-auth-token': Provider.of<UserProvider>(context, listen: false)
          .user
          .token
          .toString(),
      'id': id,
    });

    httpRequestHandler(
        response: response,
        context: context,
        onSuccess: () {
          refreshScreen();
          showSnackbar(context: context, text: 'Product Deleted');
        });
  }

  Future<List<Order>> fetchAllOrders({required BuildContext context}) async {
    List<Order> listOfOrders = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/get_orders'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token':
            Provider.of<UserProvider>(context, listen: false).user.token,
      });
      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            List orders = jsonDecode(response.body);
            listOfOrders = orders
                .map(
                  (e) => Order.fromJson(jsonEncode(e)),
                )
                .toList();
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
    return listOfOrders;
  }

  void updateStatus(
      {required BuildContext context,
      required VoidCallback onSuccess,
      required Order order,
      required int status}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/upate_status'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token':
              Provider.of<UserProvider>(context, listen: false).user.token,
        },
        body: jsonEncode({
          'orderId': order.id,
          'status': status,
        }),
      );

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(
      {required BuildContext context}) async {
    List<Sale> sales = [];
    int totalEarnings = 0;
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token':
            Provider.of<UserProvider>(context, listen: false).user.token,
      });

      httpRequestHandler(
          response: response,
          context: context,
          onSuccess: () {
            var res = jsonDecode(response.body);
            totalEarnings = res['totalEarnings'];
            sales = [
              Sale(earning: res['appliancesEarnings'], label: 'Appliances'),
              Sale(earning: res['mobilesEarnings'], label: 'Mobiles'),
              Sale(earning: res['essentialsEarnings'], label: 'Essentials'),
              Sale(earning: res['booksEarnings'], label: 'Books'),
              Sale(earning: res['fashionsEarnings'], label: 'Fashion'),
            ];
          });
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarnings,
    };
  }
}
