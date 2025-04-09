import 'package:flutter/material.dart';

import 'form_model.dart';

class FormViewModel extends ChangeNotifier {
  final FormModel model = FormModel();
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController numberFieldController = TextEditingController();
  final TextEditingController textareaFieldController = TextEditingController();

  /* 
   * 初始化
   */
  void init(BuildContext context) {
  }

  /* 
   * 离开页面
   */
  void cleanup() {
  }

  /* 
   * 设置开关值
   */
  void setSwitchValue(bool value) {
    model.switchValue = value;
    notifyListeners();
  }

  /* 
   * 设置日期字符串
   */
  void setDateStr(String value) {
    model.dateStr = value;
    notifyListeners();
  }
}
