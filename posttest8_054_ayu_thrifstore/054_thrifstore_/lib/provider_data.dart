import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class data_get extends ChangeNotifier {
  List<List<dynamic>> data_ = [];
  List<List<dynamic>> get final_ => data_;
  var documentsDirectory = null;
  change() {
    getvaluecsv_data();
    notifyListeners();
  }

  Future<void> getvaluecsv_data() async {
    data_ = [];
    documentsDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentsDirectory.path}/data.csv');
    if (file.existsSync()) {
      data_ = const CsvToListConverter().convert(
        file.readAsStringSync(),
      );
    }
  }

  Future<void> getvaluecsv_favorite() async {
    data_ = [];
    final fileFav = File('${documentsDirectory.path}/favorite.csv');
    if (!fileFav.existsSync()) {
      fileFav.writeAsString("");
    }
    if (fileFav.existsSync()) {
      data_ = const CsvToListConverter().convert(fileFav.readAsStringSync());
    }
  }

  upfile(index) async {
    final file = File('${documentsDirectory.path}/favorite.csv');
    List<List<dynamic>> existingData = const CsvToListConverter().convert(
      file.readAsStringSync(),
    );
    List<List<dynamic>> updatedData = [...existingData, data_[index]];

    final String updatedCsvData =
        const ListToCsvConverter().convert(updatedData);
    file.writeAsString(updatedCsvData, mode: FileMode.write);
    data_ = updatedData;
  }
}
