import 'package:flutter/material.dart';

import 'splash_model.dart';

class SplashViewModel extends ChangeNotifier {
  final SplashModel model = SplashModel();
  
  int get number => model.number;

  void add() {
    model.number++;
    notifyListeners();
  }

  void sub() {
    model.number--;
    notifyListeners();
  }
} 