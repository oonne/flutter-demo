import 'package:flutter/material.dart';

import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/utils/message.dart';

import 'data_model.dart';

class DataListViewModel extends ChangeNotifier {
  final DataListModel model = DataListModel();

  /*
   * 请求
   */
  // 请求
  Future<void> request(BuildContext context) async {
    if (model.isLoading) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    var [err, res] = await AuthApi.getLoginPow({
      'name': 'admin',
    });
    model.isLoading = false;
    notifyListeners();

    if (err != null) {
      model.error = getErrorMessage(context, err);
      showTextSnackBar(context, msg: getErrorMessage(context, err));
      return;
    }
    
    var resData = res['data'];
    model.result = resData['salt'];
    notifyListeners();
  }
} 