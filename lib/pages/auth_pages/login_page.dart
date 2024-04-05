import 'package:flutter/material.dart';
import 'package:pooja_pass/components/logo.dart';
import 'package:pooja_pass/components/my_btn.dart';
import 'package:pooja_pass/components/my_textfield.dart';
import 'package:pooja_pass/pages/home/home_page.dart';
import 'package:pooja_pass/services/auth_services.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onPressed;
  LoginPage({super.key, required this.onPressed});

  //*Text editing controllers
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  //*auth service
  AuthService _authService = AuthService();

  void loginUser(BuildContext context) {
    _authService.login(context, emailTextEditingController.text,
        passwordTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //*logo
                const Logo(),
                const SizedBox(height: 20),
                //*welcome msg
                Text(
                  "Welcome, login here!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 20),
                //*email
                MyTextField(
                  hintText: "Email",
                  isObscureText: false,
                  textController: emailTextEditingController,
                ),
                const SizedBox(height: 20),
                //*password
                MyTextField(
                  hintText: "Password",
                  isObscureText: true,
                  textController: passwordTextEditingController,
                ),
                const SizedBox(height: 20),

                //*login btn
                MyBtn(
                  text: "Login",
                  onTap: () {
                    //Todo:replace with real authentication
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                const SizedBox(height: 10),

                //*or sign up here
                TextButton(
                    onPressed: onPressed,
                    child: Text(
                      "Don't have an account? Sign up!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      //TODO
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
