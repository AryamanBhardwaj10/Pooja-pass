// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooja_pass/auth/login_or_register.dart';
import 'package:pooja_pass/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:pooja_pass/pages/home/home_page.dart';
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
      //
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      //
      //http req

      var jsonBody = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      });

      http.Response res = await http.post(
          Uri.parse(
            '${Constants.uri}/register',
          ),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            //todo: implement register and login straight away
            httpErrorHandle(
                response: res,
                context: context,
                onSuccess: () async {
                  //to store token locally
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();

                  Map<String, dynamic> responseData = jsonDecode(res.body);
                  Map<String, dynamic> userData = responseData['data']['user'];
                  String token = responseData['token'];
                  User user = User(
                    id: userData['_id'],
                    name: userData['name'],
                    email: userData['email'],
                    token: token,
                  );

                  userProvider.setUserFromModel(user);
                  debugPrint(user.name);

                  //todo:cross check
                  await pref.setString(
                      'x-auth-token', jsonDecode(res.body)['token']);

                  navigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
                });
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

      http.Response response = await http.post(
          Uri.parse('${Constants.uri}/login'),
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
            //!
            Map<String, dynamic> responseData = jsonDecode(response.body);
            Map<String, dynamic> userData = responseData['data']['user'];
            String token = responseData['token'];
            User user = User(
              id: userData['_id'],
              name: userData['name'],
              email: userData['email'],
              token: token,
            );

            //!

            //to store token locally
            SharedPreferences pref = await SharedPreferences.getInstance();
            // userProvider.setUser(response.body);
            userProvider.setUserFromModel(user);
            debugPrint(user.name);

            //todo:cross check
            await pref.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
            debugPrint(pref.getString('x-auth-token'));

            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          });
      // navigator.pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const HomePage()),
      //     (route) => false);
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

      if (response == true) {
        var userRes = await http
            .get(Uri.parse('${Constants.uri}/user'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });

        var userData = jsonDecode(userRes.body)['data']['user'];

        // Create user object
        User user = User(
          id: userData['_id'],
          name: userData['name'],
          email: userData['email'],
          token: token!,
        );

        // Set user in user provider
        userProvider.setUserFromModel(user);
      }
    } catch (e) {
      print(e.toString() + 'AB');
      // showSnackbar(context, e.toString());
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
