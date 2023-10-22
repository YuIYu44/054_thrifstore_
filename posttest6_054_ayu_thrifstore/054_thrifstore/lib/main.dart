import 'package:ayu054_thriftstore/login_admin.dart';
import 'package:ayu054_thriftstore/admin_menu.dart';
import 'package:ayu054_thriftstore/menu.dart';
import 'package:ayu054_thriftstore/admin_add.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ayu054_thriftstore/functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Thriftstore',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        initialRoute: '/main',
        routes: {
          '/main': (context) => Mysplash(),
          '/login': (context) => login(),
          '/menu_admin': (context) => admin_menu(),
          '/menu_add': (context) => admin_add(),
          '/menu': (context) => menu()
        });
  }
}

class Mysplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/logo.png"),
                    fit: BoxFit.fill,
                  ),
                )),
            Text("Welcome to Thriftstore",
                style: GoogleFonts.inika(
                    textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Color(0XffFFD600)))),
            Text("Let's see our collection",
                style: GoogleFonts.inika(
                    textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Color(0XffFFD600),
                        decoration: TextDecoration.underline),
                    decorationColor: Color(0XffFFD600))),
            orangeButton(context, () {
              Navigator.pushNamed(context, "/login");
            }, "ADMIN", 0.05, 0, 0, 0),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/menu");
                },
                style: OutlinedButton.styleFrom(
                    disabledBackgroundColor: Colors.white70,
                    disabledForegroundColor: Color(0Xff909090),
                    shape: BeveledRectangleBorder(),
                    side: BorderSide(width: 2.0, color: Color(0XffFFE86C))),
                child: Text("GUEST",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inika(
                      textStyle: TextStyle(
                        color: Color(0XffFFD600),
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
