import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ayu54_thriftstore/functions.dart';
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
  const admin_add({super.key});

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
    List<List<dynamic>> existingData = const CsvToListConverter().convert(
      file.readAsStringSync(encoding: utf8),
    );
    List<List<dynamic>> updatedData = [...existingData, row];

    final String updatedCsvData =
        const ListToCsvConverter().convert(updatedData);
    file.writeAsString(updatedCsvData, mode: FileMode.write);
  }

  validation(BuildContext context) async {
    if (clothesController.text.length > 10) {
      if (_image != "") {
        if (checks.where((element) => element == true).length <= 2 &&
            checks.where((element) => element == true).isNotEmpty) {
          addDataCsv([
            "${documentsDirectory.path}/pics/$_image",
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
            MaterialPageRoute(builder: (context) => const admin_add()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
              snack(context, "Berhasil Ditambahkan!", const Color(0XEEFFD600)));

          return 0;
        }
        ScaffoldMessenger.of(context).showSnackBar(snack(
            context,
            "Choose only 1 or 2 Category",
            const Color.fromARGB(150, 255, 0, 0)));
        return 0;
      }
      ScaffoldMessenger.of(context).showSnackBar(snack(context,
          "Image Can't Be Empty", const Color.fromARGB(150, 255, 0, 0)));
      return 0;
    }
    ScaffoldMessenger.of(context).showSnackBar(snack(
        context,
        "Description Contains At Least 10 Character",
        const Color.fromARGB(150, 255, 0, 0)));
    return 0;
  }

  Future<void> copyImageToFolder(String image) async {
    final Directory sourcefolder = Directory("${documentsDirectory.path}/pics");
    final File sourceFile = File(source);
    if (!sourcefolder.existsSync()) {
      sourcefolder.createSync(recursive: true);
    }
    sourceFile.copySync("${documentsDirectory.path}/pics/$image");
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
    return WillPopScope(
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
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/menu_admin');
                        }),
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
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XffFFD600)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XffFFD600)),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              labelText: "Short Description",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                          )),
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
                  }, "+", 0.015, 0.01, 0, 0.6),
                  SizedBox(
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
                            Text(category[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.025,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.5,
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        size: 70,
                      ),
                      onPressed: () {
                        validation(context);
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
