import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';

import 'user_info_model.dart';

class UserInfoViewModel extends ChangeNotifier {
  final UserInfoModel model = UserInfoModel();

  /* 
   * 初始化
   */
  init(BuildContext context) {
    getUserInfo();
  }

  /* 
   * 获取用户信息
   */
  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    model.token = prefs.getString('TOKEN');
    model.refreshToken = prefs.getString('REFRESH_TOKEN');
    model.refreshTime = prefs.getInt('TOKEN_REFRESH_TIME');
    notifyListeners();
  }

  // token 刷新时间
  String get tokenRefreshTime {
    if (model.refreshTime == null) {
      return '未获取到刷新时间';
    }

    return formatDate(DateTime.fromMillisecondsSinceEpoch(model.refreshTime!), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
  }
}
