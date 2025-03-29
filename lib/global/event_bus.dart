import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

/* 
 * 退出登录事件
 */
class LogoutEvent {
  LogoutEvent();
}

/* 
 * 测试事件
 */
class TestEvent {
  final String message;

  TestEvent(this.message);
}