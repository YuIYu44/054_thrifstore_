import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

void navigateToNext(BuildContext context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

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
        backgroundColor: Color(0XffFFD600),
        shape: BeveledRectangleBorder(),
        side: BorderSide(width: 2.0, color: Color(0XffFFE86C)),
      ),
      child: Text(
        texts,
        textAlign: TextAlign.center,
        style: GoogleFonts.inika(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Widget costumer_menu(BuildContext context, data, dropDownValue,
    Function(String) updateDropDownValue) {
  return Center(
      child: Column(children: [
    Row(children: [
      Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
          child: text(context, 0.05, "Our Collections")),
      Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
          child: DropdownButton<String>(
            value: dropDownValue,
            items: <String>[
              "all",
              "Pants",
              "Shirt",
              "Skirt",
              "Hoodie",
              "Dress",
              "Sweater"
            ].map((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            }).toList(),
            onChanged: (String? value) {
              updateDropDownValue(value!);
            },
          ))
    ]),
    show_pic(context, data)
  ]));
}

Widget aboutus(BuildContext context) {
  return Center(
      child: Column(children: [
    Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
        child: CircleAvatar(
            backgroundImage: AssetImage("asset/author.jpg"),
            minRadius: MediaQuery.of(context).size.width * 0.25)),
    text(context, 0.1, "Ayu Lestari"),
    text(context, 0.04, "the founder of ThriftStore company"),
    text(context, 0.04, "2109106054"),
    text(context, 0.06, "A'21")
  ]));
}

Widget show_pic(BuildContext context, data) {
  if (data.isNotEmpty && data[0].isNotEmpty) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.76,
      child: GridView.count(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2),
        shrinkWrap: true,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        children: List.generate(data.length, (index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                color: Colors.grey,
                width: MediaQuery.of(context).size.width * 0.38,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Image.file(
                  File(data[index].elementAt(0)),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  "Tags: ${data[index].elementAt(2).toString()}",
                  style: GoogleFonts.inika(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  } else {
    return Container();
  }
}

Widget text(BuildContext context, double sizes, texts) {
  return Text(
    texts,
    style: GoogleFonts.inika(
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * sizes,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
