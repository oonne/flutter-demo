import 'package:flutter/material.dart';

import 'home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeModel model = HomeModel();
  
  String get title => model.title;

  void updateTitle(String newTitle) {
    model.title = newTitle;
    notifyListeners();
  }
} 