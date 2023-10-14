import 'package:ayu054_thriftstore/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String password = "1234";
String username = "admin54";
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class login extends StatefulWidget {
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

void validation(BuildContext context) {
  if (usernameController.text == username) {
    if (passwordController.text == password) {
      Navigator.pushNamed(context, "/menu_admin");
    }
  }
  usernameController.text = "";
  passwordController.text = "";
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XffFFD600)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XffFFD600)),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        labelStyle: GoogleFonts.inika(
          color: Color(0XFF909090),
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: GoogleFonts.inika(
          fontSize: MediaQuery.of(context).size.height * 0.02),
    ),
  );
}
