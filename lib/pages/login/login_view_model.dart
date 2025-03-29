import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:async';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/message.dart';

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
  bool validateForm(BuildContext context) {
    bool isValid = true;
    model.nameError = null;
    model.passwordError = null;

    if (nameController.text.isEmpty) {
      model.nameError = '${AppLocalizations.of(context)!.info_please_input} ${AppLocalizations.of(context)!.account}';
      isValid = false;
    } else {
      model.nameError = null;
    }

    if (passwordController.text.isEmpty) {
      model.passwordError = '${AppLocalizations.of(context)!.info_please_input} ${AppLocalizations.of(context)!.password}';
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
    
    if (salt.isEmpty || result.isEmpty) {
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
  Future<void> login(BuildContext context) async {
    if (model.isLoading) {
      return;
    }

    // 表单验证
    if (!validateForm(context)) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    // 登录逻辑
    final stopwatch = Stopwatch()..start();
    final powKey = await calcLoginPow(nameController.text);
    stopwatch.stop();
    log.finest('pow耗时 耗时: ${stopwatch.elapsedMilliseconds} 毫秒');
    
    if (powKey.isEmpty) {
      model.isLoading = false;
      notifyListeners();
      if (!context.mounted) {
        return;
      }
      showTextSnackBar(context, msg: '登录失败');
      return;
    }

    model.isLoading = false;
    notifyListeners();
  }
}
