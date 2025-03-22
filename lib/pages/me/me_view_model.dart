import 'package:flutter/material.dart';

import 'me_model.dart';

class MeViewModel extends ChangeNotifier {
  final MeModel model = MeModel();
  
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