import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpRequestHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(
          context: context, text: jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackbar(context: context, text: jsonDecode(response.body)['error']);
      break;

    default:
      showSnackbar(context: context, text: response.body);
  }
}
