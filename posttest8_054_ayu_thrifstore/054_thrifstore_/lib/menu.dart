import 'package:ayu54_thriftstore/provider_change_page.dart';
import 'package:ayu54_thriftstore/provider_data.dart';
import 'package:ayu54_thriftstore/provider_theme.dart';
import 'package:ayu54_thriftstore/provider_zoom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayu54_thriftstore/functions.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<changepage>(create: (context) => changepage()),
          ChangeNotifierProvider<data_get>(create: (context) => data_get()),
          ChangeNotifierProvider<zooom>(create: (context) => zooom())
        ],
        child: WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Scaffold(
                appBar: AppBar_(context),
                body: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("DarkMode",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(CupertinoIcons.moon_fill),
                          onPressed: () {
                            Provider.of<CustomTheme>(context, listen: false)
                                .change_color(null);
                            Provider.of<CustomTheme>(context, listen: false)
                                .preferenced(1);
                          },
                        ),
                      ]),
                  Consumer<changepage>(
                    builder: (context, changePage, child) {
                      if (changePage.selects == 0) {
                        return costumer_menu(context);
                      } else if (changePage.selects == 1) {
                        return costumer_favorite(context);
                      } else if (changePage.selects == 2) {
                        return aboutus(context);
                      }

                      return Container();
                    },
                  ),
                ]),
                bottomNavigationBar:
                    Consumer<changepage>(builder: (context, changePage, child) {
                  return BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: changePage.selects,
                    onTap: (index) {
                      if (index != 3) {
                        changePage.change(index);
                      } else {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/main'));
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
                  );
                }))));
  }
}

Widget costumer_menu(context) {
  return FutureBuilder(
      future: Provider.of<data_get>(context, listen: false).getvaluecsv_data(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(Provider.of<data_get>(context).final_.length);
          return Center(
              child: Column(children: [
            Row(children: [
              Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: text(context, 0.05, "Our Collections")),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.3),
              )
            ]),
            if (Provider.of<data_get>(context).final_.isNotEmpty)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.7,
                child: GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                      Provider.of<data_get>(context).final_.length, (index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                          ),
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          child: ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))),
                              onPressed: () {
                                Provider.of<data_get>(context, listen: false)
                                    .upfile(index);
                              },
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
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Text(
                              "Tags: ${Provider.of<data_get>(context).final_[index].elementAt(2).toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )),
                      ],
                    );
                  }),
                ),
              )
            else
              Container()
          ]));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}

Widget costumer_favorite(BuildContext context) {
  return FutureBuilder(
      future: Provider.of<data_get>(context).getvaluecsv_favorite(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
              child: Column(children: [
            Row(children: [
              Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: text(context, 0.05, "Your Collections")),
            ]),
            if (Provider.of<data_get>(context).final_.isNotEmpty)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.7,
                child: GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                      Provider.of<data_get>(context).final_.length, (index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                          ),
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          child: ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))),
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
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Text(
                              "Tags: ${Provider.of<data_get>(context).final_[index].elementAt(2).toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )),
                      ],
                    );
                  }),
                ),
              )
            else
              Container()
          ]));
        }
        if (snapshot.hasError) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}

@override
Widget aboutus(BuildContext context) {
  return GestureDetector(
      onTap: () {
        Provider.of<zooom>(context, listen: false).change();
      },
      child: Center(
          child: Column(children: [
        AnimatedContainer(
            width: Provider.of<zooom>(context).selects
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width * 0.35,
            height: Provider.of<zooom>(context).selects
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width * 0.35,
            alignment: Provider.of<zooom>(context).selects
                ? Alignment.center
                : AlignmentDirectional.topCenter,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
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
