/* 
 * 定时任务
 */
import 'dart:async';

import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/log.dart';

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
    // 如果已存在定时器，先取消
    _timer?.cancel();
    
    _timer = Timer.periodic(Duration(milliseconds: tokenRefreshTime), (timer) {
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
    log.finest("准备刷新token");
  }
}