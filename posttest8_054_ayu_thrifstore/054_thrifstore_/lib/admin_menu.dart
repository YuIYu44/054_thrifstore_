import 'package:ayu54_thriftstore/provider_data.dart';
import 'package:ayu54_thriftstore/provider_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayu54_thriftstore/functions.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<data_get>(
        create: (context) => data_get(),
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
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.045,
                            ),
                            child: Text(
                              'Admin',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                            )),
                        ListTile(
                          leading: const Icon(
                            Icons.settings,
                          ),
                          title: Text('Pengaturan Akun',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 16)),
                          onTap: () {
                            Navigator.pushNamed(context, '/configuration');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.login_outlined),
                          title: Text('Logout',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 16)),
                          onTap: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/main'));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                body: Consumer<data_get>(builder: (context, changePage, child) {
                  return pic(context);
                }))));
  }

  Widget pic(context) {
    return FutureBuilder(
        future:
            Provider.of<data_get>(context, listen: false).getvaluecsv_data(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(CupertinoIcons.moon_fill),
                            onPressed: () {
                              Provider.of<CustomTheme>(context, listen: false)
                                  .change_color(null);
                              Provider.of<CustomTheme>(context, listen: false)
                                  .preferenced(1);
                            },
                          ),
                        ])),
                if (Provider.of<data_get>(context).final_.isNotEmpty)
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.sizeOf(context).width * 0.05,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: GridView.count(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 2),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          scrollDirection: Axis.vertical,
                          children: List.generate(
                              Provider.of<data_get>(context).final_.length,
                              (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: ElevatedButton(
                                      clipBehavior: Clip.antiAlias,
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0))),
                                      onPressed: () {},
                                      child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: Image.file(
                                            File(Provider.of<data_get>(context)
                                                .final_[index]
                                                .elementAt(0)),
                                            fit: BoxFit.cover,
                                          ))),
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    child: Text(
                                      "Tags: ${Provider.of<data_get>(context).final_[index].elementAt(2).toString()}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    )),
                              ],
                            );
                          }),
                        ),
                      ))
                else
                  Container(),
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
            ));
          } else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
