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
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar_(context),
          endDrawer: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
            child: Drawer(
              width: MediaQuery.of(context).size.width * 0.5,
              backgroundColor: Colors.yellow,
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
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Pengaturan Akun'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.login_outlined),
                    title: const Text('Logout'),
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
                show_pic(context, data),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.68,
                  left: MediaQuery.of(context).size.width * 0.33,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/menu_add');
                    },
                    child: Icon(Icons.add_circle,
                        size: MediaQuery.of(context).size.width * 0.15,
                        color: Colors.white),
                    fillColor: Color(0XffFFD600),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
