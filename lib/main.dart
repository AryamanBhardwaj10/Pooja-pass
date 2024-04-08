import 'package:flutter/material.dart';
import 'package:pooja_pass/auth/login_or_register.dart';
import 'package:pooja_pass/pages/home/home_page.dart';
import 'package:pooja_pass/pages/ticket/ticket_qr_page.dart';
import 'package:pooja_pass/provider/user_provider.dart';
import 'package:pooja_pass/services/auth_services.dart';
import 'package:pooja_pass/theme/light_mode.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //#f4f4f4
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? const LoginOrRegister()
          : const HomePage(),
    );
  }
}
