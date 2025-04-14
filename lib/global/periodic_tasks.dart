/* 
 * 定时任务
 */
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_demo/global/event_bus.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/api/modules/auth.dart';
import 'package:flutter_demo/models/staff.dart';

/* 
 * 刷新token
 */
class RefreshTokenManager {
  // 私有静态实例，确保全局只有一个实例
  static final RefreshTokenManager _instance = RefreshTokenManager._internal();
  Timer? _timer;

  // 工厂构造函数
  // 1. 工厂构造函数可以控制对象的创建过程
  // 2. 每次调用 RefreshTokenManager() 都会返回同一个实例
  // 3. 这样可以确保整个应用中只有一个 RefreshTokenManager 实例
  factory RefreshTokenManager() {
    return _instance;
  }

  // 私有命名构造函数
  // 1. 使用 _internal() 作为私有构造函数，防止外部直接创建实例
  // 2. 只能通过工厂构造函数获取实例
  // 3. 确保单例模式的实现
  RefreshTokenManager._internal();

  /* 
   * 开始执行token刷新任务
   */
  void start() {
    // 立即执行一次
    _executeTask();
    
    // 如果已存在定时器，先取消
    _timer?.cancel();
    
    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      _executeTask();
    });
  }

  /* 
   * 停止token刷新任务
   */
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /* 
   * 刷新toekn任务
   */
  Future<void> _executeTask() async {
    final prefs = await SharedPreferences.getInstance();
    final staffInfoStr = prefs.getString('STAFF_INFO');
    final refreshToken = prefs.getString('REFRESH_TOKEN');
    final refreshTime = prefs.getInt('TOKEN_REFRESH_TIME');

    if (refreshToken == null || refreshTime == null || staffInfoStr == null) {
      return;
    }

    // 如果当前时间与refreshTime差值小于 tokenRefreshTime，则不用刷新
    if (DateTime.now().millisecondsSinceEpoch - refreshTime < tokenRefreshTime) {
      return;
    }

    final staffInfo = IStaff.fromJson(jsonDecode(staffInfoStr));
    var [err, res] = await AuthApi.refreshToken({
      'staffId': staffInfo.staffId,
      'refreshToken': refreshToken,
    });

    if (err != null) {
      if (err['code'] == 'code_1001003') {
        eventBus.fire(LogoutEvent());
        log.finest('换票失败，退出登录');
        return;
      }
      log.finest('换票失败');
      return;
    }

    // 更新token
    prefs.setString('TOKEN', res['data']['token']);
    prefs.setString('REFRESH_TOKEN', res['data']['refreshToken']);
    prefs.setInt('TOKEN_REFRESH_TIME', DateTime.now().millisecondsSinceEpoch);

    log.finest('换票成功');
  }
}