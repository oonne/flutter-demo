import 'package:flutter/foundation.dart';

/*
 * 全局的状态管理
 */
class GlobalState extends ChangeNotifier {
  /* 
   * 全局数字
   */
  int globalNum = 100;

  // 设置全局数字
  void setGlobalNum(int num) {
    globalNum = num;
    notifyListeners();
  }
}
