import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

bool darkMode = true;
void navigateToNext(BuildContext context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

AppBar AppBar_(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(color: darkMode ? Colors.white : Colors.black),
    backgroundColor: darkMode ? Colors.black45 : Colors.white,
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

Widget show_pic(
    BuildContext context, List<dynamic> data, onpresseds, documentsDirectory) {
  if (data.isNotEmpty && data[0].isNotEmpty) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.7,
      child: GridView.count(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2),
        shrinkWrap: true,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        children: List.generate(data.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                child: ElevatedButton(
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    onPressed: () {
                      if (onpresseds == 1) {
                        final file =
                            File('${documentsDirectory.path}/favorite.csv');
                        List<List<dynamic>> existingData =
                            CsvToListConverter().convert(
                          file.readAsStringSync(encoding: utf8),
                        );
                        List<List<dynamic>> updatedData = [
                          ...existingData,
                          data[index]
                        ];

                        final String updatedCsvData =
                            const ListToCsvConverter().convert(updatedData);
                        file.writeAsString(updatedCsvData,
                            mode: FileMode.write);
                      }
                    },
                    child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.file(
                          File(data[index].elementAt(0)),
                          fit: BoxFit.cover,
                        ))),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  "Tags: ${data[index].elementAt(2).toString()}",
                  style: GoogleFonts.inika(
                    color: darkMode ? Colors.white : Colors.black,
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
        color: darkMode ? Colors.white : Colors.black,
        fontSize: MediaQuery.of(context).size.width * sizes,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
