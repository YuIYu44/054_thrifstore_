import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayu054_thriftstore/functions.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<List<dynamic>> data = [[]];
Directory documentsDirectory = Directory("");

class admin_menu extends StatefulWidget {
  @override
  State<admin_menu> createState() => _menu();
}

class _menu extends State<admin_menu> {
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
    return Theme(
        data: ThemeData(
          scaffoldBackgroundColor: darkMode ? Colors.black45 : Colors.white,
        ),
        child: WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Scaffold(
              appBar: AppBar_(context),
              endDrawer: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                child: Drawer(
                  width: MediaQuery.of(context).size.width * 0.5,
                  backgroundColor: darkMode ? Colors.grey[800] : Colors.yellow,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            bottom: MediaQuery.of(context).size.height * 0.045,
                          ),
                          child: Text(
                            'Admin',
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: darkMode ? Colors.white : Colors.black,
                        ),
                        title: Text('Pengaturan Akun',
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.login_outlined,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text('Logout',
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black)),
                        onTap: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/main'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: Center(
                child: Stack(
                  children: [
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.sizeOf(context).width * 0.7,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("DarkMode",
                                  style: TextStyle(
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              CupertinoSwitch(
                                value: darkMode,
                                onChanged: (value) {
                                  setState(() {
                                    darkMode = !darkMode;
                                  });
                                },
                              ),
                            ])),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.sizeOf(context).width * 0.05,
                        child: show_pic(context, data, 0, documentsDirectory)),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.72,
                      left: MediaQuery.sizeOf(context).width * 0.4,
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/menu_add');
                        },
                        child: Icon(Icons.add_circle,
                            size: MediaQuery.of(context).size.width * 0.15,
                            color: darkMode ? Colors.black : Colors.white),
                        fillColor: Color(0XffFFD600),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
