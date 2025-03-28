import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/message.dart';

import 'req_model.dart';

class ReqViewModel extends ChangeNotifier {
  final ReqModel model = ReqModel();

  /*
   * 请求
   */
  // 是否请求中
  bool get isLoading => model.isLoading;

  // 请求结果
  String get result => model.result;

  // 请求错误
  String get error => model.error;

  // 请求
  Future<void> request(BuildContext context) async {
    if (model.isLoading) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    var [err, res] = await AuthApi.getLoginPow({});
    model.isLoading = false;
    notifyListeners();

    if (err != null) {
      model.error = getErrorMessage(context, err);
      showTextSnackBar(context, msg: getErrorMessage(context, err));
      return;
    }
    
    log.finest(res);
  }
} 