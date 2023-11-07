import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar AppBar_(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery.of(context).size.width * 0.2,
    title: Image.asset(
      "asset/logo.png",
      width: MediaQuery.of(context).size.width * 0.4,
    ),
  );
}

Widget orangeButton(BuildContext context, VoidCallback onPressed, String texts,
    num tops, bottoms, lefts, rights) {
  return Container(
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * tops,
      bottom: MediaQuery.of(context).size.height * bottoms,
      left: MediaQuery.of(context).size.width * lefts,
      right: MediaQuery.of(context).size.width * rights,
    ),
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
        side: const BorderSide(width: 2.0, color: Color(0XffFFE86C)),
      ),
      child: Text(
        texts,
        textAlign: TextAlign.center,
        style: GoogleFonts.inika(
          textStyle: TextStyle(
            color: const Color.fromARGB(255, 255, 214, 8),
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Widget text(BuildContext context, double sizes, texts) {
  return Text(
    texts,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: MediaQuery.of(context).size.width * sizes,
          fontWeight: FontWeight.w700,
        ),
  );
}

SnackBar snack(BuildContext context, text, color) {
  return SnackBar(
    content: Text(text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.all(10),
    backgroundColor: color,
  );
}
