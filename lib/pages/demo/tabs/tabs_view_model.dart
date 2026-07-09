import 'package:flutter/material.dart';

import 'tabs_model.dart';

class TabsViewModel extends ChangeNotifier {
  final TabsModel model = TabsModel();

  void init(Map<String, dynamic>? extra) {
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    model.selectedIndex = index;
    notifyListeners();
  }
}