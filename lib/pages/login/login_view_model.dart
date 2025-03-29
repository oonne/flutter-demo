import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/message.dart';
import 'package:flutter_demo/models/staff.dart';

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

    // 计算pow
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
      showTextSnackBar(context, msg: AppLocalizations.of(context)!.msg_login_failed);
      return;
    }

    // 登录
    var [err, res] = await AuthApi.login({
      'powKey': powKey,
      'name': nameController.text,
      'password': createHash(passwordController.text, 32),
    });
    model.isLoading = false;
    notifyListeners();

    if (err != null) {
      if (!context.mounted) {
        return;
      }
      showTextSnackBar(context, msg: getErrorMessage(context, err, defaultMessage: AppLocalizations.of(context)!.msg_login_failed));
      return;
    }

    // 登录成功后存储数据
    final prefs = await SharedPreferences.getInstance();
    if (!context.mounted) {
      return;
    }
    final globalState = Provider.of<GlobalState>(context, listen: false);

    prefs.setString('TOKEN', res['data']['token']);
    prefs.setString('REFRESH_TOKEN', res['data']['refreshToken']);
    prefs.setInt('TOKEN_REFRESH_TIME', DateTime.now().millisecondsSinceEpoch);
    globalState.setStaffInfo(IStaff.fromJson(res['data']['staff']));
    
    showTextSnackBar(context, msg: '登录成功');
  }
}
