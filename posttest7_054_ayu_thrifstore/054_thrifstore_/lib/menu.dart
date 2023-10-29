import 'package:flutter/material.dart';
import 'package:ayu54_thriftstore/functions.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<List<dynamic>> data = [[]];
List<List<dynamic>> data_favorites = [[]];
Directory documentsDirectory = Directory("");

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menu();
}

class _menu extends State<menu> {
  int _index = 0;
  String dropDownValue = "All"; // Initial value
  String dropDownValue_2 = "All"; // Initial value

  void updateDropDownValue(String value, onpressed) {
    setState(() {
      getvaluecsv();
      if (value != "All" && onpressed == 1) {
        dropDownValue = value;
        data = data.where((item) => item[2].contains(value)).toList();
      }
      if (value != "All" && onpressed == 0) {
        dropDownValue_2 = value;
        data_favorites =
            data_favorites.where((item) => item[2].contains(value)).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await dir();
    getvaluecsv();
    setState(() {});
  }

  Future<void> dir() async {
    documentsDirectory = await getApplicationDocumentsDirectory();
  }

  void getvaluecsv() async {
    final file = File('${documentsDirectory.path}/data.csv');
    final fileFav = File('${documentsDirectory.path}/favorite.csv');
    if (!fileFav.existsSync()) {
      fileFav.writeAsString("");
    }
    if (fileFav.existsSync()) {
      data_favorites = const CsvToListConverter()
          .convert(fileFav.readAsStringSync(encoding: utf8));
    }
    if (file.existsSync()) {
      data = const CsvToListConverter().convert(
        file.readAsStringSync(encoding: utf8),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      costumer_menu(context, data, dropDownValue, updateDropDownValue, 1),
      costumer_menu(
          context, data_favorites, dropDownValue_2, updateDropDownValue, 0),
      const aboutus(),
    ];
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar_(context),
            body: Column(children: [switch_darkmode(context), pages[_index]]),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _index,
              onTap: (index) {
                fetchData();
                if (index != 3) {
                  setState(() {
                    _index = index;
                  });
                } else {
                  Navigator.of(context).popUntil(ModalRoute.withName('/main'));
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded,
                      size: MediaQuery.of(context).size.width * 0.08),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite,
                      size: MediaQuery.of(context).size.width * 0.08),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_sharp,
                      size: MediaQuery.of(context).size.width * 0.08),
                  label: "About Us",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.login_outlined,
                      size: MediaQuery.of(context).size.width * 0.08),
                  label: "Logout",
                ),
              ],
            )));
  }
}

Widget costumer_menu(BuildContext context, datas, dropValue,
    Function(String, int) updateDropDownValue, onpresseds) {
  return Center(
      child: Column(children: [
    Row(children: [
      Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
          child: text(context, 0.05,
              onpresseds == 0 ? "Your Collections" : "Our Collections")),
      Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
          child: DropdownButton<String>(
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            value: dropValue,
            items: <String>[
              "All",
              "Pants",
              "Shirt",
              "Skirt",
              "Hoodie",
              "Dress",
              "Sweater"
            ].map((String val) {
              return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val,
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith()));
            }).toList(),
            onChanged: (String? value) {
              updateDropDownValue(value!, onpresseds);
            },
          ))
    ]),
    show_pic(context, datas, onpresseds, documentsDirectory)
  ]));
}

class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<aboutus> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Center(
            child: Column(children: [
          AnimatedContainer(
              width: selected
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.35,
              height: selected
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.35,
              alignment:
                  selected ? Alignment.center : AlignmentDirectional.topCenter,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.17),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const ClipOval(
                  child: Image(
                image: AssetImage("asset/author.jpg"),
                fit: BoxFit.cover,
              ))),
          text(context, 0.1, "Ayu Lestari"),
          text(context, 0.04, "the founder of ThriftStore company"),
          text(context, 0.04, "2109106054"),
          text(context, 0.06, "A'21")
        ])));
  }
}
