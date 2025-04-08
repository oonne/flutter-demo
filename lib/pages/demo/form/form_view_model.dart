import 'package:flutter/material.dart';

import 'form_model.dart';

class FormViewModel extends ChangeNotifier {
  final FormModel model = FormModel();
  final TextEditingController textFieldController = TextEditingController();

  /* 
   * 初始化
   */
  init(BuildContext context) {
  }
}
