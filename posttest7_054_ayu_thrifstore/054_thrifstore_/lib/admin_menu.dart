import 'package:flutter/material.dart';
import 'package:ayu54_thriftstore/functions.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<List<dynamic>> data = [[]];
Directory documentsDirectory = Directory("");

class admin_menu extends StatefulWidget {
  const admin_menu({super.key});

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
      data = const CsvToListConverter().convert(
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
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.045,
                      ),
                      child: Text(
                        'Admin',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                    ),
                    title: Text('Pengaturan Akun',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 14)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.login_outlined),
                    title: Text('Logout',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 14)),
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
                    child: switch_darkmode(context)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.sizeOf(context).width * 0.05,
                    child: show_pic(context, data, 0, documentsDirectory)),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.72,
                  left: MediaQuery.sizeOf(context).width * 0.4,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      size: 60,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/menu_add');
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
