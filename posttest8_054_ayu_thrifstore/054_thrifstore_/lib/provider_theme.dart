import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme extends ChangeNotifier {
  ThemeData? currentTheme;
  SharedPreferences? prefs;
  bool dark = false;
  Color? clr;
  CustomTheme(int edit) {
    preferenced(edit);
  }
  bool get themes => dark;
  preferenced(int edit) async {
    final prefs = await SharedPreferences.getInstance();
    bool? dark_ = prefs.getBool('darkmode');
    if (dark_ == null) {
      final brightness = ThemeMode.system.name;
      dark = brightness == Brightness.dark;
    }
    if (dark_ != null) {
      dark = dark_;
    }
    if (edit == 1) {
      dark = !dark;
    }
    await prefs.setBool('darkmode', dark);
    if (dark == true) {
      setDarkmode();
    } else {
      setLightMode();
    }
  }

  change_color(Color? clrs) {
    clr = clrs;
  }

  setLightMode() {
    currentTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: clr ?? Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:
              clr == null ? const Color(0XffFFD600) : clr!.withOpacity(0.8),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[800]),
      drawerTheme: DrawerThemeData(
          backgroundColor:
              clr == null ? Color(0XEFFFD600) : clr!.withOpacity(0.8)),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromARGB(100, 0, 0, 0);
        }
        return clr ?? const Color(0XffFFD600);
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
      appBarTheme: AppBarTheme(
          color: clr == null ? Colors.black87 : clr!.withOpacity(0.8)),
      scaffoldBackgroundColor: Colors.black87,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: clr ?? Colors.black12,
          selectedItemColor: Colors.grey[800],
          unselectedItemColor: Colors.white),
      drawerTheme: DrawerThemeData(
          backgroundColor:
              clr == null ? Color(0xEF000000) : clr!.withOpacity(0.8)),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.black45;
        }
        return clr ?? Colors.white;
      }))),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.inika(color: Colors.white),
      ),
    );
    notifyListeners();
  }
}
