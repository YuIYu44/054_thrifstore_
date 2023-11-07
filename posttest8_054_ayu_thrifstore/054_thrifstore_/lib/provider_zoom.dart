import 'package:flutter/cupertino.dart';

class zooom extends ChangeNotifier {
  bool selected = false;
  bool get selects => selected;
  change() {
    selected = !selected;
    notifyListeners();
  }
}
