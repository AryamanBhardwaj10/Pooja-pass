// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooja_pass/models/ticket.dart';
import 'package:pooja_pass/utils/constants.dart';
import 'package:pooja_pass/utils/utils.dart';
import 'package:http/http.dart' as http;

class TicketServices {
  //*getting user tickets
  // Future<List<Ticket>?> getUserTickets(
  //     BuildContext context, String userId) async {
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('${Constants.uri}/tickets/$userId'));

  //     if (res.statusCode == 200) {
  //       final dataBody = jsonDecode(res.body);
  //       if (dataBody["status"] == 'success') {
  //         final ticketList = dataBody['data']['tickets'] as List;
  //         return ticketList
  //             .map((ticketData) => Ticket.fromJson(ticketData))
  //             .toList();
  //       } else {
  //         //todo:need better error handling
  //         throw Exception('A P I  response error');
  //       }
  //     } else {
  //       throw Exception("Failed to load data");
  //     }
  //   } catch (e) {
  //     // TODO
  //     showSnackbar(context, e.toString());
  //     return null;
  //   }
  // }

  //!------

  Future<List<Ticket>> getUserTickets(
      BuildContext context, String userId) async {
    try {
      http.Response res =
          await http.get(Uri.parse('${Constants.uri}/tickets/$userId'));

      if (res.statusCode == 200) {
        final dataBody = jsonDecode(res.body);
        if (dataBody["status"] == 'success') {
          final ticketList = dataBody['data']['tickets'] as List;
          return ticketList
              .map((ticketData) => Ticket.fromJson(ticketData))
              .toList();
        } else {
          //todo:need better error handling
          throw Exception('A P I  response error');
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      // TODO
      showSnackbar(context, e.toString());
      return []; // Return an empty list if an error occurs
    }
  }

  //!-------

  //*book ticket
  Future<Ticket?> bookTicket(BuildContext context, String userId, String email,
      String ticketDate, List<String> memberNames) async {
    final url = Uri.parse('${Constants.uri}/tickets/$userId');
    String qrCode = generateQRCode(email, ticketDate, memberNames);
    final data = {
      'qrCode': qrCode,
      'ticketDate': ticketDate,
      'memberNames': memberNames,
    };
    //actual post req
    try {
      http.Response res = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      );
      if (res.statusCode == 201) {
        debugPrint(res.body);
        final dataBody = jsonDecode(res.body);

        if (dataBody['status'] == "success") {
          final ticketData = dataBody['data']['ticket'];
          return Ticket.fromJson(ticketData);
        } else {
          throw Exception('Ticket not created');
        }
      } else {
        throw Exception('Failed to book the ticket');
      }
    } catch (e) {
      debugPrint(e.toString());
      showSnackbar(context, e.toString());
      return null;
    }
  }

  //*generate qrcode
  String generateQRCode(
      String email, String ticketDate, List<String> memberNames) {
    final currentDate = DateTime.now().toIso8601String();
    final memListStr = memberNames.join(',');
    final String qrcode = '$email:$currentDate:for:$ticketDate:$memListStr';
    return qrcode;
  }
}
