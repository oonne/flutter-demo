import 'package:flutter/material.dart';
import 'package:flutter_demo/global/state.dart';

import 'demo_model.dart';

class DemoViewModel extends ChangeNotifier {
  final DemoModel model = DemoModel();

  /* 
   * 初始化
   */
  init(Map<String, dynamic>? extra) {
    model.number = extra?['num'] ?? 0;

    model.globalNum = GlobalState().globalNum;
  }

  /* 
   * 全局数字
   */
  int get globalNum => model.globalNum;

  void setGlobalNum(int num) {
    model.globalNum = num;
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
