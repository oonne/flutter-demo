import 'package:flutter/material.dart';

import 'scan_result_model.dart';

class ScanResultViewModel extends ChangeNotifier {
  final ScanResultModel model = ScanResultModel();

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