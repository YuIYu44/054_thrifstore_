import 'package:ayu54_thriftstore/functions.dart';
import 'package:ayu54_thriftstore/provider_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class themeconfig extends StatelessWidget {
  themeconfig({super.key});
  List<dynamic> colors_dark = [
    [const Color.fromARGB(255, 5, 9, 49), "Navy"],
    [const Color.fromARGB(255, 103, 29, 6), "Dark Red"],
    [Colors.green[900], "Dark Green"],
    [Colors.black, "Default"]
  ];
  List<dynamic> colors_light = [
    [const Color.fromARGB(255, 211, 176, 217), "Light Pink"],
    [const Color.fromARGB(255, 85, 163, 228), "Light Blue"],
    [Colors.brown[300], "Soft Brown"],
    [Colors.yellow, "Default"]
  ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> screen;

    if (Provider.of<CustomTheme>(context, listen: false).themes == true) {
      screen = colors_dark;
    } else {
      screen = colors_light;
    }
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        margin: EdgeInsets.only(
            top: 100, right: MediaQuery.of(context).size.width * 0.75),
        child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      Container(
          margin: EdgeInsets.fromLTRB(50, 50, 0, 0),
          child: text(context, 0.08, "Choose Your Color Schemes ")),
      Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: MediaQuery.sizeOf(context).width * 0.02,
                  mainAxisSpacing: MediaQuery.sizeOf(context).height * 0.02),
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.1),
              scrollDirection: Axis.vertical,
              itemCount: screen == colors_dark
                  ? colors_dark.length
                  : colors_light.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CustomTheme>(context, listen: false)
                          .change_color(screen[index][0]);
                      screen == colors_light
                          ? Provider.of<CustomTheme>(context, listen: false)
                              .setLightMode()
                          : Provider.of<CustomTheme>(context, listen: false)
                              .setDarkmode();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context)
                                .bottomNavigationBarTheme
                                .unselectedItemColor!)),
                    icon: Icon(
                      CupertinoIcons.lightbulb_fill,
                      size: MediaQuery.sizeOf(context).width * 0.2,
                      color: screen[index][0],
                    ),
                  ),
                  text(context, 0.03, screen[index][1])
                ]);
              })),
    ])));
  }
}
