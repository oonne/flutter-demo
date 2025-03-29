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

  // 密码是否可见
  bool get isPasswordVisible => model.isPasswordVisible;

  // 切换密码可见状态
  void togglePasswordVisibility() {
    model.isPasswordVisible = !model.isPasswordVisible;
    notifyListeners();
  }

  /*
  * 表单校验
  */
  String? get nameError => model.nameError;
  String? get passwordError => model.passwordError;

  // 验证表单
  bool validateForm() {
    bool isValid = true;
    model.nameError = null;
    model.passwordError = null;

    if (nameController.text.isEmpty) {
      model.nameError = '请输入账号';
      isValid = false;
    } else {
      model.nameError = null;
    }

    if (passwordController.text.isEmpty) {
      model.passwordError = '请输入密码';
      isValid = false;
    } else {
      model.passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  /* 
   * 登录
   */
  void login() {
    if (model.isLoading) {
      return;
    }

    // 表单验证
    if (!validateForm()) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    // 登录逻辑
    // TODO

    model.isLoading = false;
    notifyListeners();
  }
}
