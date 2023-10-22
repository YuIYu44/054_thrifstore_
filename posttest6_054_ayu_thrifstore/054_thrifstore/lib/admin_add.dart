import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ayu054_thriftstore/functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final TextEditingController clothesController = TextEditingController();
String _image = "", source = "";
Directory documentsDirectory = Directory("damn");
List<bool> checks = List.generate(6, (_) => false);
List<String> category = [
  "Pants",
  "Shirt",
  "Skirt",
  "Hoodie",
  "Dress",
  "Sweater"
];

class admin_add extends StatefulWidget {
  @override
  State<admin_add> createState() => _add();
}

class _add extends State<admin_add> {
  void refreshPage() {
    setState(() {
      clothesController.text = "";
      _image = "";
      source = "";
      checks = List.generate(6, (_) => false);
    });
  }

  void addDataCsv(List<dynamic> row) async {
    final file = File('${documentsDirectory.path}/data.csv');
    if (!file.existsSync()) {
      file.writeAsString("");
    }
    List<List<dynamic>> existingData = CsvToListConverter().convert(
      file.readAsStringSync(encoding: utf8),
    );
    List<List<dynamic>> updatedData = [...existingData, row];

    final String updatedCsvData =
        const ListToCsvConverter().convert(updatedData);
    file.writeAsString(updatedCsvData, mode: FileMode.write);
  }

  void validation(BuildContext context) async {
    if (clothesController.text.length > 10) {
      if (_image != "") {
        if (checks.where((element) => element == true).length <= 2 &&
            checks.where((element) => element == true).length > 0) {
          addDataCsv([
            "${documentsDirectory.path}/pics/${_image}",
            clothesController.text,
            category
                .asMap()
                .entries
                .where((entry) => checks[entry.key])
                .map((entry) => entry.value)
                .join(' & ')
          ]);
          await copyImageToFolder(_image);
          refreshPage();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => admin_add()),
          );
        }
      }
    }
  }

  Future<void> copyImageToFolder(String image) async {
    final Directory sourcefolder = Directory("${documentsDirectory.path}/pics");
    final File sourceFile = File(source);
    if (!sourcefolder.existsSync()) {
      sourcefolder.createSync(recursive: true);
    }
    sourceFile.copySync("${documentsDirectory.path}/pics/${image}");
  }

  Widget istherepicture() {
    if (source == "") {
      return Container();
    }
    return Image.file(
      File(source),
      fit: BoxFit.fill,
    );
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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            right: MediaQuery.of(context).size.width * 0.75),
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/menu_admin', ModalRoute.withName('/login'));
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: MediaQuery.of(context).size.width * 0.1,
                            color: Colors.white,
                          ),
                          fillColor: Color(0Xff909090),
                          shape: CircleBorder(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.1),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            color: Colors.grey,
                            child: istherepicture(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                top: MediaQuery.of(context).size.height * 0.1),
                            child: TextFormField(
                              controller: clothesController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XffFFD600)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XffFFD600)),
                                ),
                                filled: true,
                                fillColor:
                                    darkMode ? Colors.black : Colors.white,
                                labelText: "Short Description",
                                labelStyle: GoogleFonts.inika(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              style: GoogleFonts.inika(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                          )
                        ],
                      ),
                      orangeButton(context, () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        documentsDirectory =
                            await getApplicationDocumentsDirectory();
                        if (pickedFile != null) {
                          setState(() {
                            source = pickedFile.path;
                            _image = pickedFile.name;
                          });
                        }
                      }, "add", 0.015, 0.01, 0, 0.55),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.71,
                        height: MediaQuery.of(context).size.height * 0.105,
                        child: GridView.count(
                          childAspectRatio: 2,
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: List.generate(6, (index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: checks[index],
                                  onChanged: (newValue) {
                                    setState(() {
                                      checks[index] = newValue!;
                                    });
                                  },
                                ),
                                Text(
                                  category[index],
                                  style: GoogleFonts.inika(
                                    color:
                                        darkMode ? Colors.white : Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.45,
                        ),
                        child: Text(
                          "*choose max 2",
                          style: GoogleFonts.inika(
                            textStyle: TextStyle(
                              color: darkMode ? Colors.white : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.5,
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: RawMaterialButton(
                          onPressed: () {
                            validation(context);
                          },
                          child: Icon(
                            Icons.add_circle,
                            size: MediaQuery.of(context).size.width * 0.125,
                            color: Colors.white,
                          ),
                          fillColor: Color(0Xff909090),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
