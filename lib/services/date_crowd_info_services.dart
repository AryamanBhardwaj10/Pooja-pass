import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooja_pass/models/date_crowd_info.dart';
import 'package:http/http.dart' as http;
import 'package:pooja_pass/utils/constants.dart';
import 'package:pooja_pass/utils/utils.dart';

class DateCrowdInfoServices {
  static Future<DateCrowdInfo?> fetchDateCrowdInfo(
      BuildContext context, DateTime date) async {
    String dateString = formatDateToString(date);

    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/dateCrowdInfo/$dateString'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == "success") {
          final parsedData = {
            'date': data['data']['desiredDate']['date'],
            'maxCap': data['data']['desiredDate']['maxCap'],
            'bookedTickets': data['data']['desiredDate']['bookedTickets'],
          };

          return DateCrowdInfo.fromJson(parsedData);
        } else {
          showSnackbar(context, "API response error");
          return null;
        }
      } else {
        throw Exception(
            'Failed to load data: ${res.statusCode}'); // Throw exception for non-200 status codes
      }
    } catch (e) {
      showSnackbar(context, "Error fetching data");
      return null;
    }
  }

  static String formatDateToString(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
