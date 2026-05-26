import 'package:flutter/services.dart';
import 'log.dart';

class FlavorUtils {
  static const MethodChannel _channel =
      MethodChannel('com.runawaystar.flutter_demo/flavor');

  static Future<String?> getFlavor() async {
    try {
      final String? flavor = await _channel.invokeMethod('getFlavor');
      log.info("获取到的flavor: $flavor");
      return flavor;
    } on PlatformException catch (e) {
      log.warning("获取flavor失败: ${e.message}");
      return null;
    }
  }
}