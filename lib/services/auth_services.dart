// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooja_pass/auth/login_or_register.dart';
import 'package:pooja_pass/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:pooja_pass/pages/home/home_page.dart';
import 'package:pooja_pass/provider/user_provider.dart';
import 'package:pooja_pass/provider/user_provider.dart';
import 'package:pooja_pass/utils/constants.dart';
import 'package:pooja_pass/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup
  Future<void> signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      User user = User(id: 'id', name: name, email: email, token: '');
      //http req
      //todo:replace with actual endpoint
      http.Response res = await http.post(
          Uri.parse(
            '${Constants.uri}/api/signup',
          ),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(
                context, "Account created! login with same credentials");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //login
  void login(BuildContext context, String email, String password) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      //todo: replace with actual endpoint
      http.Response response = await http.post(
          Uri.parse('${Constants.uri}/api/login'),
          body: jsonEncode(
            {
              'email': email,
              'password': password,
            },
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            //to store token locally
            SharedPreferences pref = await SharedPreferences.getInstance();
            userProvider.setUser(response.body);
            //todo:cross check
            await pref.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
          });
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, e.toString());
    }
  }

  //get user data
  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      //todo: replace with valid endpoint
      var tokenRes = await http.post(Uri.parse('${Constants.uri}/isTokenValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          });

      var response = jsonDecode(tokenRes.body);
      //todo:replace with the required response
      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('${Constants.uri}/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });

        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //logout
  void logout(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('x-auth-token', "");

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginOrRegister()),
        (route) => false);
  }
}
