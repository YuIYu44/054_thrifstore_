import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme extends ChangeNotifier {
  ThemeData? currentTheme;
  SharedPreferences? prefs;
  bool? dark;
  CustomTheme(int edit) {
    preferenced(edit);
  }
  preferenced(int edit) async {
    final prefs = await SharedPreferences.getInstance();
    bool? dark = prefs.getBool('darkmode');
    if (dark == null && edit == 0) {
      await prefs.setBool('darkmode', true);
    } else if (edit == 1 && dark != null) {
      dark = !dark;
      await prefs.setBool('darkmode', dark);
    }
    if (dark == true) {
      setDarkmode();
    } else {
      setLightMode();
    }
  }

  setLightMode() {
    currentTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0XffFFD600),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[800]),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0XEFFFD600)),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromARGB(100, 0, 0, 0);
        }
        return const Color(0XffFFD600);
      }))),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.inika(color: Colors.black87),
      ),
    );
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(color: Colors.black87),
      scaffoldBackgroundColor: Colors.black87,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black12,
          selectedItemColor: Colors.grey[800],
          unselectedItemColor: Colors.white),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xEF000000)),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.black45;
        }
        return Colors.white;
      }))),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.inika(color: Colors.white),
      ),
    );
    notifyListeners();
  }
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

Widget show_pic(
    BuildContext context, List<dynamic> data, onpresseds, documentsDirectory) {
  if (data.isNotEmpty && data[0].isNotEmpty) {
    return SizedBox(
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
                            const CsvToListConverter().convert(
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
                  margin: const EdgeInsets.only(top: 5, left: 10),
                  child: Text(
                    "Tags: ${data[index].elementAt(2).toString()}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                  )),
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
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: MediaQuery.of(context).size.width * sizes,
          fontWeight: FontWeight.w700,
        ),
  );
}

Widget switch_darkmode(context) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("DarkMode",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
        CupertinoSwitch(
          value: false,
          onChanged: (value) {
            final themeProvider =
                Provider.of<CustomTheme>(context, listen: false);
            themeProvider.preferenced(1);
          },
        ),
      ]);
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
