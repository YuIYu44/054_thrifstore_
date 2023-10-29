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

// class Mysplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 height: MediaQuery.of(context).size.height * 0.15,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("asset/logo.png"),
//                     fit: BoxFit.fill,
//                   ),
//                 )),
//             Text("Welcome to Thriftstore",
//                 style: GoogleFonts.inika(
//                     textStyle: TextStyle(
//                         fontSize: MediaQuery.of(context).size.width * 0.07,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0XffFFD600)))),
//             Text("Let's see our collection",
//                 style: GoogleFonts.inika(
//                     textStyle: TextStyle(
//                         fontSize: MediaQuery.of(context).size.width * 0.05,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0XffFFD600),
//                         decoration: TextDecoration.underline),
//                     decorationColor: Color(0XffFFD600))),
//             orangeButton(context, () {
//               Navigator.pushNamed(context, "/login");
//             }, "ADMIN", 0.05, 0, 0, 0),
//             Container(
//               child: orangeButton(context, () {
//                 Navigator.pushNamed(context, "/menu");
//               }, "GUEST", 0.01, 0, 0, 0),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
