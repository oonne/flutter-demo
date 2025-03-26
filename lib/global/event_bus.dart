import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 测试事件
class TestEvent {
  final String message;

  TestEvent(this.message);
}
