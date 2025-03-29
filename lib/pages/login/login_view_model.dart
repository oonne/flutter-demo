import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/utils.dart';

import 'login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginModel model = LoginModel();

  /* 
   * 输入框
   */
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 切换密码是否可见
  void togglePasswordVisibility() {
    model.isPasswordVisible = !model.isPasswordVisible;
    notifyListeners();
  }

  /*
  * 表单校验
  */
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
   * 计算登录pow
   */
  Future<String> calcLoginPow(String name) async {
    var [err, res] = await AuthApi.getLoginPow({
      'name': name,
    });
    
    if (err != null) {
      return '';
    }

    final salt = res['data']['salt'];
    final result = res['data']['result'];
    
    if (salt == null || result == null) {
      return '';
    }

    String powKey = '';

    while (true) {
      powKey = randomString(32);
      final hash = sha512.convert(utf8.encode(powKey + salt)).toString();

      if (hash.substring(hash.length - loginPowLength) == result.substring(result.length - loginPowLength)) {
        break;
      }
    }
    return powKey;
  }

  /* 
   * 登录
   */
  // 登录
  Future<void> login() async {
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
    final powKey = await calcLoginPow(nameController.text);
    debugPrint('powKey: $powKey');

    model.isLoading = false;
    notifyListeners();
  }
}
