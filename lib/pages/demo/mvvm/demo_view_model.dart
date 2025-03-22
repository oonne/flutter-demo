import 'package:flutter/material.dart';

import 'demo_model.dart';

class DemoViewModel extends ChangeNotifier {
  final DemoModel model = DemoModel();

  /* 
   * 初始化
   */
  init(Map<String, dynamic>? extra) {
    model.number = extra?['num'] ?? 0;
  }

  /* 
   * 页面数字
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
