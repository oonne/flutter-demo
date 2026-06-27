import 'package:flutter/material.dart';

import 'number_keyboard_model.dart';

class NumberKeyboardViewModel extends ChangeNotifier {
  final NumberKeyboardModel model = NumberKeyboardModel();

  final TextEditingController integerController = TextEditingController();
  final TextEditingController decimalController = TextEditingController();
  final TextEditingController negativeController = TextEditingController();
  final TextEditingController decimalNegativeController = TextEditingController();

  final FocusNode integerFocusNode = FocusNode();
  final FocusNode decimalFocusNode = FocusNode();
  final FocusNode negativeFocusNode = FocusNode();
  final FocusNode decimalNegativeFocusNode = FocusNode();

  void init(Map<String, dynamic>? extra) {
    notifyListeners();
  }

  void cleanup() {
    integerController.dispose();
    decimalController.dispose();
    negativeController.dispose();
    decimalNegativeController.dispose();
    integerFocusNode.dispose();
    decimalFocusNode.dispose();
    negativeFocusNode.dispose();
    decimalNegativeFocusNode.dispose();
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

  void confirmDecimalNegative() {
    model.decimalNegativeValue = decimalNegativeController.text;
    notifyListeners();
  }
}