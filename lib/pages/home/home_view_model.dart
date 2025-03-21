import 'package:flutter/material.dart';

import 'home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeModel model = HomeModel();

  /* 
   * 初始化
   */
  init() {
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