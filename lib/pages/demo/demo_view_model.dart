import 'package:flutter/material.dart';

import 'demo_model.dart';

class DemoViewModel extends ChangeNotifier {
  final DemoModel model = DemoModel();
  
  String get title => model.title;

  void updateTitle(String newTitle) {
    model.title = newTitle;
    notifyListeners();
  }
} 