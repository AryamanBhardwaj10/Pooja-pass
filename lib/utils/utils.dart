import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    onSuccess();
  } else {
    final responseBody = jsonDecode(response.body);
    showSnackbar(context, responseBody['message']);
  }
}
