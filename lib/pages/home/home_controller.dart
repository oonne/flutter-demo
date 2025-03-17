import 'package:flutter/material.dart';

import 'home_model.dart';

class HomeController extends ChangeNotifier {
  final HomeModel _model = HomeModel();

  // 更新标题
  void updateTitle(String newTitle) {
    _model.title = newTitle;
    notifyListeners();
  }

  // 更新描述
  void updateDescription(String newDescription) {
    _model.description = newDescription;
    notifyListeners();
  }
} 