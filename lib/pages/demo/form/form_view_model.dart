import 'package:flutter/material.dart';

import 'form_model.dart';

class FormViewModel extends ChangeNotifier {
  final FormModel model = FormModel();
  final TextEditingController textFieldController = TextEditingController();

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
}
