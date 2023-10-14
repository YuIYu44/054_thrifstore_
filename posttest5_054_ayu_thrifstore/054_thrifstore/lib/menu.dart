import 'package:flutter/material.dart';
import 'package:ayu054_thriftstore/functions.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<List<dynamic>> data = [[]];
Directory documentsDirectory = Directory("");

class menu extends StatefulWidget {
  @override
  State<menu> createState() => _menu();
}

class _menu extends State<menu> {
  int _index = 0;
  String dropDownValue = "all"; // Initial value

  void updateDropDownValue(String value) {
    setState(() {
      dropDownValue = value;
      getvaluecsv();
      if (value != "all") {
        data = data.where((item) => item[2].contains(value)).toList();
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
    if (file.existsSync()) {
      data = CsvToListConverter().convert(
        file.readAsStringSync(encoding: utf8),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      costumer_menu(context, data, dropDownValue, updateDropDownValue),
      // favorites(),
      costumer_menu(context, data, dropDownValue, updateDropDownValue),
      aboutus(context)
    ];
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar_(context),
            body: pages[_index],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.yellow[600],
              unselectedItemColor: Colors.grey[600],
              selectedItemColor: Colors.white,
              currentIndex: _index,
              onTap: (index) {
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
