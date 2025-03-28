import 'package:flutter/material.dart';

import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/utils/log.dart';

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
  Future<void> request() async {
    if (model.isLoading) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    var [err, res] = await AuthApi.getLoginPow({});
    model.isLoading = false;
    notifyListeners();

    if (err != null) {
      // model.error = err;
      log.finest(err);
      return;
    }
    
    log.finest(res);
  }
} 