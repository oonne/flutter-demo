import 'package:flutter/material.dart';

import 'mvvm_model.dart';

class MvvmViewModel extends ChangeNotifier {
  final MvvmModel model = MvvmModel();

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
