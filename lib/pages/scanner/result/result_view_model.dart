import 'package:flutter/material.dart';

import 'result_model.dart';

class ResultViewModel extends ChangeNotifier {
  final ResultModel model = ResultModel();

  /* 
   * 初始化
   */
  Future<void> init(Map<String, dynamic>? extra) async {
    model.result = extra?['result'] ?? '';
    notifyListeners();
  }

  /* 
   * 扫码结果
   */
  String get result => model.result;
} 