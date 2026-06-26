import 'package:flutter/material.dart';

import 'number_keyboard_model.dart';

class NumberKeyboardViewModel extends ChangeNotifier {
  final NumberKeyboardModel model = NumberKeyboardModel();

  final TextEditingController integerController = TextEditingController();
  final TextEditingController decimalController = TextEditingController();
  final TextEditingController negativeController = TextEditingController();

  final FocusNode integerFocusNode = FocusNode();
  final FocusNode decimalFocusNode = FocusNode();
  final FocusNode negativeFocusNode = FocusNode();

  void init(Map<String, dynamic>? extra) {
    notifyListeners();
  }

  void cleanup() {
    integerController.dispose();
    decimalController.dispose();
    negativeController.dispose();
    integerFocusNode.dispose();
    decimalFocusNode.dispose();
    negativeFocusNode.dispose();
  }

  void confirmInteger() {
    model.integerValue = integerController.text;
    notifyListeners();
  }

  void confirmDecimal() {
    model.decimalValue = decimalController.text;
    notifyListeners();
  }

  void confirmNegative() {
    model.negativeValue = negativeController.text;
    notifyListeners();
  }
}