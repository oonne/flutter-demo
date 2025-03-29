import 'package:flutter/material.dart';

import 'login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginModel model = LoginModel();

  /* 
   * 输入框
   */
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /* 
   * 登录
   */
  void login() {
    if (model.isLoading) {
      return;
    }

    model.isLoading = true;
    notifyListeners();
    
    
  }
} 