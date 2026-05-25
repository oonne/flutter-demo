import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 广告管理器类
///
/// 负责管理穿山甲广告SDK的所有核心操作，包括：
/// - SDK初始化配置
/// - 获取SDK版本信息
/// - 请求广告权限
/// - 主题模式管理
///
/// 使用单例模式，确保整个应用只有一个广告管理器实例
class AdManager {
  // ==========================================================================
  // 静态属性
  // ==========================================================================

  /// SDK是否已初始化的标志
  /// 避免重复初始化，减少系统资源消耗
  static bool _isInitialized = false;

  /// 缓存的SDK版本号
  /// 初始化后存储，后续获取可直接使用
  static String _sdkVersion = '';

  // ==========================================================================
  // Getter属性
  // ==========================================================================

  /// 获取SDK初始化状态
  /// - true: 已初始化，可以正常使用广告功能
  /// - false: 未初始化，需要先调用 init() 方法
  static bool get isInitialized => _isInitialized;

  /// 获取SDK版本号
  /// 只有在SDK初始化后才能获取到正确的版本信息
  static String get sdkVersion => _sdkVersion;

  // ==========================================================================
  // 核心方法
  // ==========================================================================

  /// 初始化广告SDK
  ///
  /// 这是使用广告功能的前提条件，必须在应用启动时调用一次。
  /// 该方法会完成以下配置：
  /// - 注册应用信息（AppID、应用名称）
  /// - 配置隐私权限（位置、设备ID等）
  /// - 配置用户信息（用于精准广告投放）
  /// - 设置网络环境（允许下载的广告网络类型）
  ///
  /// 示例：
  /// ```dart
  /// await AdManager.init();
  /// ```
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('UUID') ?? '000000000000';
    final String env = dotenv.env['ENV_NAME'] ?? '';

    // 检查是否已经初始化，避免重复操作
    if (_isInitialized) {
      log.info('广告SDK已经初始化');
      return;
    }

    try {
      // 调用穿山甲SDK的注册方法，配置所有必要参数
      await FlutterUnionad.register(
        // 基础配置
        androidAppId: adAndroidAppId, // Android AppID
        iosAppId: adIosAppId, // iOS AppID
        appName: adAppName, // 应用名称
        useMediation: false, // 是否使用聚合功能
        // 用户相关配置
        paid: true, // 是否为付费用户，影响广告类型
        keywords: '', // 用户兴趣关键词，用于精准投放
        // SDK 行为配置
        allowShowNotify: false, // 是否允许 SDK 在通知栏显示提示
        debug: env != 'prod', // 调试模式（生产环境关闭）
        supportMultiProcess: true, // 是否支持多进程
        // 主题配置（0-日间模式，1-夜间模式）
        themeStatus: FlutterUnionAdTheme.DAY,

        // 允许直接下载的网络类型配置
        // 在这些网络环境下，SDK可以直接下载广告相关的App
        directDownloadNetworkType: [
          FlutterUnionadNetCode.NETWORK_STATE_2G, // 2G网络
          FlutterUnionadNetCode.NETWORK_STATE_3G, // 3G网络
          FlutterUnionadNetCode.NETWORK_STATE_4G, // 4G网络
          FlutterUnionadNetCode.NETWORK_STATE_WIFI, // WiFi网络
        ],

        // Android隐私配置
        // 控制SDK是否能获取各种设备和隐私权限
        androidPrivacy: AndroidPrivacy(
          // 地理位置相关
          isCanUseLocation: false, // 是否允许SDK使用定位功能
          lat: 0.0, // 纬度（禁用SDK自动获取时使用）
          lon: 0.0, // 经度（禁用SDK自动获取时使用）
          // 设备标识相关
          isCanUsePhoneState: false, // 是否允许获取手机状态（imei等）
          imei: '', // 手动传入的imei
          isCanUseWifiState: false, // 是否允许获取WiFi状态
          macAddress: '', // 手动传入的Mac地址
          isCanUseWriteExternal: false, // 是否允许写入外部存储
          // 广告标识相关
          oaid: '', // 手动传入的OAID（移动安全联盟标识）
          alist: false, // 是否获取应用安装列表
          isCanUseAndroidId: false, // 是否允许获取Android ID
          androidId: '', // 手动传入的Android ID
          // 权限相关
          isCanUsePermissionRecordAudio: false, // 是否允许录音权限
          // 广告偏好相关
          isLimitPersonalAds: false, // 是否限制个性化广告
          isProgrammaticRecommend: true, // 是否启用程序化广告推荐
          // SDK隐私配置（JSON格式）
          userPrivacyConfig: {
            'mcod': '0', // 控制OAID获取频率，"0"关闭
            'installUninstallListen': '0', // 关闭应用安装/卸载监听
          },
        ),

        // iOS隐私配置
        iosPrivacy: IOSPrivacy(
          limitPersonalAds: false, // 是否限制个性化广告
          limitProgrammaticAds: false, // 是否限制程序化广告
          forbiddenCAID: false, // 是否禁用CAID
        ),

        // 用户信息配置
        // 用于广告精准投放和流量分组
        userInfo: UnionadUserInfo(
          userId: uuid, // 用户唯一标识
          age: 0, // 用户年龄（0表示未知）
          gender: 2, // 性别：0女 1男 2未知 3不使用
          channel: 'app', // 渠道名称
          subChannel: 'app', // 子渠道名称
          userValueGroup: '', // 流量分组标识
          customInfos: {}, // 自定义参数
        ),
      );

      // 标记初始化完成
      _isInitialized = true;
      log.info('广告SDK初始化成功');

      // 获取并缓存SDK版本号
      _sdkVersion = await getSDKVersion();
      log.info('广告SDK版本: $_sdkVersion');
    } catch (e) {
      // 初始化失败，记录错误并向上抛出
      log.severe('广告SDK初始化失败: $e');
      rethrow;
    }
  }

  /// 获取SDK版本号
  ///
  /// 返回穿山甲广告SDK的当前版本字符串
  /// 可用于排查版本兼容性问题
  ///
  /// 返回值：
  /// - 成功：版本号字符串，如 "3.5.0.0"
  /// - 失败：返回 "error"
  static Future<String> getSDKVersion() async {
    try {
      final version = await FlutterUnionad.getSDKVersion();
      return version;
    } catch (e) {
      log.severe('获取SDK版本失败: $e');
      return 'error';
    }
  }

  /// 请求广告相关权限
  ///
  /// 根据不同平台请求不同的权限：
  /// - Android：定位权限、存储权限等（可选）
  /// - iOS 14+：ATT（App Tracking Transparency）权限
  ///
  /// ATT权限用于获取 IDFA（广告标识符），对广告精准投放很重要
  /// iOS用户可以拒绝此权限，SDK会自动降级处理
  ///
  /// 回调说明：
  /// - notDetermined: 用户还未做出选择（iOS特有）
  /// - restricted: 权限被系统限制
  /// - denied: 用户明确拒绝权限
  /// - authorized: 用户授权允许
  static Future<void> requestPermission() async {
    try {
      await FlutterUnionad.requestPermissionIfNecessary(
        callBack: FlutterUnionadPermissionCallBack(
          notDetermined: () {
            // 用户还未做出选择（首次弹窗未选择）
            log.info('广告权限: 未确定');
          },
          restricted: () {
            // 权限被系统限制（如家长控制）
            log.info('广告权限: 受限制');
          },
          denied: () {
            // 用户明确拒绝了权限请求
            log.warning('广告权限: 被拒绝');
          },
          authorized: () {
            // 用户授权同意，可进行精准广告投放
            log.info('广告权限: 已授权');
          },
        ),
      );
    } catch (e) {
      log.severe('请求广告权限失败: $e');
    }
  }

  /// 获取当前主题模式
  ///
  /// 用于适配日间/夜间模式切换
  ///
  /// 返回值：
  /// - 0: 正常/日间模式
  /// - 1: 夜间模式
  static Future<int> getThemeStatus() async {
    try {
      final status = await FlutterUnionad.getThemeStatus();
      return status;
    } catch (e) {
      log.severe('获取主题状态失败: $e');
      return 0;
    }
  }
}
