import 'package:ayu54_thriftstore/introduction_page.dart';
import 'package:ayu54_thriftstore/login_admin.dart';
import 'package:ayu54_thriftstore/admin_menu.dart';
import 'package:ayu54_thriftstore/menu.dart';
import 'package:ayu54_thriftstore/admin_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ayu54_thriftstore/functions.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(ChangeNotifierProvider<CustomTheme>(
    create: (_) => CustomTheme(0),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Thriftstore',
        theme: Provider.of<CustomTheme>(context).currentTheme,
        initialRoute: '/main',
        routes: {
          '/main': (context) => const IntroductionPage(),
          '/login': (context) => const login(),
          '/menu_admin': (context) => const admin_menu(),
          '/menu_add': (context) => const admin_add(),
          '/menu': (context) => const menu()
        });
  }
}
