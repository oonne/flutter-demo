import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String _title = '首页';
  String get title => _title;

  void updateTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
} 