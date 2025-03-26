import 'package:flutter/material.dart';

import 'eventbus_model.dart';

class EventbusViewModel extends ChangeNotifier {
  final EventbusModel model = EventbusModel();

  /* 
   * 初始化
   */
  init(Map<String, dynamic>? extra) {
    model.number = extra?['num'] ?? 0;
    notifyListeners();
  }

  /* 
   * 数字
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
