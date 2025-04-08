import 'package:flutter/material.dart';

import 'form_model.dart';

class FormViewModel extends ChangeNotifier {
  final FormModel model = FormModel();
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController numberField1Controller = TextEditingController();
  final TextEditingController numberField2Controller = TextEditingController();
  final TextEditingController numberField3Controller = TextEditingController();
  final TextEditingController numberField4Controller = TextEditingController();

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
