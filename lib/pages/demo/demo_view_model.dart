import 'package:flutter/material.dart';


import 'demo_model.dart';

class DemoViewModel extends ChangeNotifier {
  final DemoModel model = DemoModel();

  /* 
   * 数字控制
   */
  int get number => model.number;

  void add() {
    model.number++;
    notifyListeners();
  }

  void sub() {
    model.number--;
    notifyListeners();
  }
}
