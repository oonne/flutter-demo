import 'package:flutter/material.dart';
import 'package:flutter_demo/global/state.dart';

import 'home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeModel model = HomeModel();

  /* 
   * 初始化
   */
  init() {
    model.globalNum = globalState.globalNum;
  }

  /* 
   * 全局数字
   */
  int get globalNum => model.globalNum;

  void setGlobalNum(int num) {
    model.globalNum = num;
    globalState.globalNum = num;
    notifyListeners();
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