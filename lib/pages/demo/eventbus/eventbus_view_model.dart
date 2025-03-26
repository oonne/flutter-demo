import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_demo/global/event_bus.dart';

import 'eventbus_model.dart';

class EventbusViewModel extends ChangeNotifier {
  final EventbusModel model = EventbusModel();
  StreamSubscription? _subscription;

  /* 
   * 初始化
   */
  init() {
    debugPrint('初始化');
    _subscription = eventBus.on<TestEvent>().listen((event) {
      debugPrint('收到事件：${event.message}');
    });
  }

  /* 
   * 离开页面
   */
  cleanup() {
    _subscription?.cancel();
    debugPrint('清理');
  }

  /* 
   * 发送事件
   */
  void sendEvent() {
    debugPrint('发送事件');
    eventBus.fire(TestEvent('测试事件'));
  }
}
