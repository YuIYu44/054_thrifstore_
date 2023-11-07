import 'package:ayu54_thriftstore/functions.dart';
import 'package:flutter/material.dart';

String password = "1234";
String username = "admin54";
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _Mylogin();
}

class _Mylogin extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.11),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/login_logo.png"),
                    fit: BoxFit.fill,
                  ),
                )),
            TextFields(usernameController, false, "Username", context),
            TextFields(passwordController, true, "Password", context),
            orangeButton(context, () {
              validation(context);
            }, "LOGIN", 0.05, 0.01, 0, 0),
          ],
        ),
      ),
    );
  }
}

validation(BuildContext context) {
  if (usernameController.text == username) {
    if (passwordController.text == password) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snack(context, "Login Succesfull", const Color(0XEEFFD600)));
      Navigator.pushReplacementNamed(context, "/menu_admin");
      usernameController.text = "";
      passwordController.text = "";
      return 0;
    }
  }
  usernameController.text = "";
  passwordController.text = "";
  ScaffoldMessenger.of(context).showSnackBar(
      snack(context, "Login Failed", const Color.fromARGB(150, 255, 0, 0)));
}

Widget TextFields(
  TextEditingController controllers,
  bool obscure,
  String labelText,
  BuildContext context,
) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.06,
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * 0.04,
      right: MediaQuery.of(context).size.width * 0.2,
      left: MediaQuery.of(context).size.width * 0.2,
    ),
    child: TextField(
      controller: controllers,
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XffFFD600)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XffFFD600)),
        ),
        filled: true,
        fillColor: Colors.transparent,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(fontSize: MediaQuery.of(context).size.height * 0.02),
    ),
  );
}
