import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_demo/global/event_bus.dart';
import 'package:flutter_demo/utils/toast.dart';

import 'l18n_demo_model.dart';

class L18nDemoViewModel extends ChangeNotifier {
  final L18nDemoModel model = L18nDemoModel();
  StreamSubscription? _subscription;

  /* 
   * 初始化
   */
  init(BuildContext context) {
    _subscription = eventBus.on<TestEvent>().listen((event) {
      if (context.mounted) {
        showTextSnackBar(context, msg: event.message);
      }
    });
  }

  /* 
   * 离开页面
   */
  cleanup() {
    _subscription?.cancel();
  }

  /* 
   * 发送事件
   */
  void sendEvent() {
    eventBus.fire(TestEvent('测试事件'));
  }
}
