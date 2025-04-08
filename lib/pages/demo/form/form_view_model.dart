import 'package:flutter/material.dart';

import 'form_model.dart';

class FormViewModel extends ChangeNotifier {
  final FormModel model = FormModel();
  late final TextEditingController textFieldController;

  /* 
   * 初始化
   */
  void init(BuildContext context) {
    textFieldController = TextEditingController();
  }

  /* 
   * 离开页面
   */
  void cleanup() {
    textFieldController.dispose();
  }

  /* 
   * 设置开关值
   */
  void setSwitchValue(bool value) {
    model.switchValue = value;
    notifyListeners();
  }
}
