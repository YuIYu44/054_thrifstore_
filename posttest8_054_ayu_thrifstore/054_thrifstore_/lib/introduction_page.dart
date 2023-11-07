import 'package:ayu54_thriftstore/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      next: Text("I'm Admin",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              )),
      back: Text("I'm User",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              )),
      showBackButton: true,
      showDoneButton: false,
      onDone: () {
        Navigator.of(context).pop();
      },
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.17,
                  bottom: MediaQuery.sizeOf(context).height * 0.05),
              child: Image.asset(
                "asset/logo.png",
                fit: BoxFit.fill,
                width: 340,
                height: 150,
              ),
            ),
            Text(
              "Welcome to Thriftstore",
              style: GoogleFonts.inika(
                  textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0XffFFD600))),
              textAlign: TextAlign.center,
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "See our collections\n&\n Choose your favorite",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center,
                )),
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: orangeButton(context, () {
                  Navigator.pushNamed(context, "/menu");
                }, "Join", 0.00, 0, 0.3, 0.3)),
          ]),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.15,
                  bottom: MediaQuery.sizeOf(context).height * 0.05),
              child: Image.asset(
                "asset/admin.png",
                fit: BoxFit.fill,
                width: 300,
                height: 250,
              ),
            ),
            Text(
              "ADMIN ONLY",
              style: GoogleFonts.inika(
                  textStyle: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0XffFFD600))),
              textAlign: TextAlign.center,
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "Join us by clicking button below",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center,
                )),
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: orangeButton(context, () {
                  Navigator.pushNamed(context, "/login");
                }, "ADMIN", 0.00, 0, 0.3, 0.3)),
          ]),
        ),
      ],
    );
  }
}
