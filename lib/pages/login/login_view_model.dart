import 'package:flutter/material.dart';

import 'package:flutter_demo/api/modules/auth.dart';

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
    
    // 登录逻辑
    // TODO
    
    model.isLoading = false;
  }
} 