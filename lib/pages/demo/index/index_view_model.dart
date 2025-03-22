import 'package:flutter/material.dart';

import 'index_model.dart';

class IndexViewModel extends ChangeNotifier {
  final IndexModel model = IndexModel();

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