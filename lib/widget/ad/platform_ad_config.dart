import 'dart:io';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/flavor_utils.dart';

/// 广告平台配置获取工具
///
/// 负责根据当前运行平台（Android/iOS）返回对应的广告配置
/// 调用方无需关心平台判断逻辑，直接使用此类获取配置即可

class PlatformAdConfig {
  /// 获取当前平台的广告配置对象
  ///
  /// 根据 Platform.isAndroid 或 Platform.isIOS 判断返回对应平台的配置对象
  static AdConfig get _currentConfig {
    if (Platform.isIOS) {
      return adIosConfig;
    } else if (Platform.isAndroid) {
      return _getAndroidConfig();
    }
    return adGoogleplayConfig;
  }

  static AdConfig _getAndroidConfig() {
    final flavor = FlavorUtils.cachedFlavor;
    switch (flavor) {
      case 'googleplay':
        return adGoogleplayConfig;
      case 'xiaomi':
        return adXiaomiConfig;
      case 'oppo':
        return adOppoConfig;
      case 'vivo':
        return adVivoConfig;
      case 'honor':
        return adHonorConfig;
      default:
        return adGoogleplayConfig;
    }
  }

  /// 获取当前平台的 AppID
  static String get appId => _currentConfig.appId;

  /// 获取当前平台的应用名称
  static String get appName => adAppName;

  /// 获取当前平台的开屏广告代码位ID
  ///
  /// 开屏广告是用户打开App时看到的第一个广告
  static String get splashCodeId => _currentConfig.splashCodeId;

  /// 获取当前平台的 Banner广告代码位ID（300x150尺寸）
  ///
  /// Banner广告是一种固定在页面顶部或底部的条形广告
  /// 尺寸：宽300dp 高150dp
  static String get bannerCodeId300_150 => _currentConfig.bannerCodeId300_150;

  /// 获取当前平台的 Banner广告代码位ID（300x45尺寸）
  static String get bannerCodeId300_45 => _currentConfig.bannerCodeId300_45;

  /// 根据 Banner广告尺寸标识获取对应的代码位ID
  ///
  /// [sizeKey] 尺寸标识，可选值：
  /// - '300_150': 宽300dp 高150dp
  /// - '300_45': 宽300dp 高45dp
  ///
  /// 返回对应平台的代码位ID，如果尺寸标识不合法则返回默认的 300x150 代码位ID
  static String getBannerCodeId(String sizeKey) {
    switch (sizeKey) {
      case '300_150':
        return bannerCodeId300_150;
      case '300_45':
        return bannerCodeId300_45;
      default:
        return bannerCodeId300_150;
    }
  }
}
