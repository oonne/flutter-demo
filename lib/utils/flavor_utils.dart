import 'package:flutter/services.dart';
import 'log.dart';

class FlavorUtils {
  static const MethodChannel _channel =
      MethodChannel('com.runawaystar.flutter_demo/flavor');

  static String? _cachedFlavor;

  static String? get cachedFlavor => _cachedFlavor;

  static Future<String?> getFlavor() async {
    if (_cachedFlavor != null) {
      return _cachedFlavor;
    }
    try {
      final String? flavor = await _channel.invokeMethod('getFlavor');
      log.info("获取到的flavor: $flavor");
      _cachedFlavor = flavor;
      return flavor;
    } on PlatformException catch (e) {
      log.warning("获取flavor失败: ${e.message}");
      return null;
    }
  }
}