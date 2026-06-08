import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

import 'mvvm_model.dart';

class MvvmViewModel extends ChangeNotifier {
  final MvvmModel model = MvvmModel();

  /* 
   * 初始化
   */
  void init(Map<String, dynamic>? extra) {
    model.number = extra?['num'] ?? 0;
    _calculateDecimal();
    notifyListeners();
  }

  /* 
   * 数字
   */
  void add() {
    model.number++;
    notifyListeners();
  }

  void sub() {
    model.number--;
    notifyListeners();
  }

  /* 
   * 精度计算
   */
  void _calculateDecimal() {
    model.directlyResult = '0.1 + 0.2 = ${0.1 + 0.2}';
    model.decimalResult = '0.1 + 0.2 = ${Decimal.parse('0.1') + Decimal.parse('0.2')}';
  }
}
