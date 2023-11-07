import 'package:flutter/cupertino.dart';

class changepage extends ChangeNotifier {
  int selected = 0;
  int get selects => selected;
  change(index) {
    selected = index;
    notifyListeners();
  }
}
