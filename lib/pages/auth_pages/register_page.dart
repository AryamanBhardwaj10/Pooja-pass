import 'package:flutter/material.dart';
import 'package:pooja_pass/components/logo.dart';
import 'package:pooja_pass/components/my_btn.dart';
import 'package:pooja_pass/components/my_textfield.dart';
import 'package:pooja_pass/services/auth_services.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onPressed;
  RegisterPage({super.key, required this.onPressed});

  //*Text controllers
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  //*Auth service
  final AuthService _authService = AuthService();

  //*signup
  void signup(BuildContext context) {
    _authService.signUpUser(
      context,
      nameTextEditingController.text,
      emailTextEditingController.text,
      passwordTextEditingController.text,
    );
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
                  "Register here!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 20),
                //*name
                MyTextField(
                  hintText: "Name",
                  isObscureText: false,
                  textController: nameTextEditingController,
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

                //*Confirm password
                MyTextField(
                  hintText: "Password",
                  isObscureText: true,
                  textController: confirmPasswordTextEditingController,
                ),
                const SizedBox(height: 20),

                //*register btn
                MyBtn(
                  text: "Register",
                  onTap: () {
                    signup(context);
                  },
                ),
                const SizedBox(height: 10),

                //*or sign up here
                TextButton(
                    onPressed: onPressed,
                    child: Text(
                      "Already have an account? Login!",
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
