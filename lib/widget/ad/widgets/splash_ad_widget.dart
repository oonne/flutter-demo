import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/widget/ad/platform_ad_config.dart';
import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/utils/log.dart';

/// 开屏广告组件的回调函数类型定义
/// 用于处理开屏广告的各种事件回调
typedef SplashAdCallback = void Function();

/// 开屏广告Widget
///
/// 开屏广告（ Splash Ad ）是用户在打开App时看到的第一个广告，
/// 通常展示3-5秒后自动消失或显示跳过按钮让用户提前关闭。
///
/// 主要特点：
/// - 全屏展示，视觉效果强
/// - 通常在应用启动时展示
/// - 支持跳过按钮，用户可以提前关闭
/// - 支持DeepLink深度链接
///
/// 使用示例：
/// ```dart
/// SplashAdWidget(
///   timeout: 5000,
///   onShow: () => print('广告展示'),
///   onFinish: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage())),
/// )
/// ```
class SplashAdWidget extends StatefulWidget {
  // ==========================================================================
  // 构造函数参数
  // ==========================================================================

  /// 广告占比高度占屏幕高度的比例
  /// 默认值为 0.85（占85%屏幕高度）
  final double heightFraction;

  /// 广告展示成功回调
  /// 当广告成功展示时触发
  final SplashAdCallback? onShow;

  /// 广告被点击回调
  /// 当用户点击广告内容时触发
  final SplashAdCallback? onClick;

  /// 用户点击跳过按钮回调
  /// 当用户主动点击跳过按钮时触发，通常在这里跳转到主页
  final SplashAdCallback? onSkip;

  /// 广告倒计时结束回调
  /// 当广告展示倒计时结束时触发（通常是3-5秒后）
  /// 通常在这里跳转到主页
  final SplashAdCallback? onFinish;

  /// 广告加载超时回调
  /// 当广告在规定时间内未能加载成功时触发
  final SplashAdCallback? onTimeOut;

  /// 广告加载失败回调
  /// 当广告加载过程中发生错误时触发，参数为错误信息
  final Function(String)? onFail;

  // ==========================================================================
  // 构造函数
  // ==========================================================================

  const SplashAdWidget({
    super.key,
    this.heightFraction = 0.85,
    this.onShow,
    this.onClick,
    this.onSkip,
    this.onFinish,
    this.onTimeOut,
    this.onFail,
  });

  @override
  State<SplashAdWidget> createState() => _SplashAdWidgetState();
}

/// 开屏广告组件的状态类
///
/// 负责构建穿山甲SDK的开屏广告视图
class _SplashAdWidgetState extends State<SplashAdWidget> {
  bool _isShowAd = true;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      // 从全局状态读取是否显示广告
      final globalState = Provider.of<GlobalState>(context, listen: false);
      _isShowAd = globalState.isShowAd;

      // 如果不显示广告，直接触发完成回调
      if (!_isShowAd) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onFinish?.call();
        });
        return;
      }

      // 检查开屏广告代码位ID是否有效
      final splashCodeId = PlatformAdConfig.splashCodeId;
      if (splashCodeId.isEmpty) {
        log.warning('开屏广告代码位ID为空');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onFinish?.call();
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 如果不显示广告，返回空容器
    if (!_isShowAd) {
      return const SizedBox.shrink();
    }

    // 检查开屏广告代码位ID是否有效
    final splashCodeId = PlatformAdConfig.splashCodeId;
    if (splashCodeId.isEmpty) {
      log.warning('开屏广告代码位ID为空');
      return const SizedBox.shrink();
    }

    // 使用屏幕的宽高作为广告视图尺寸
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final adHeight = screenHeight * widget.heightFraction;

    // 构建穿山甲SDK的开屏广告视图
    return SizedBox(
      width: screenWidth,
      height: adHeight,
      child: FlutterUnionadSplashAdView(
        androidCodeId: splashCodeId,
        iosCodeId: splashCodeId,

        // 功能配置
        supportDeepLink: true, // 是否支持DeepLink深度链接
        width: screenWidth, // 广告视图宽度
        height: screenHeight, // 广告视图高度
        hideSkip: false, // 是否隐藏跳过按钮
        timeout: 3000, // 超时时间
        // 回调配置
        callBack: FlutterUnionadSplashCallBack(
          // 广告展示成功
          onShow: () {
            log.info('开屏广告显示');
            widget.onShow?.call();
          },

          // 广告被点击
          onClick: () {
            log.info('开屏广告点击');
            widget.onClick?.call();
          },

          // 广告加载失败
          onFail: (error) {
            log.warning('开屏广告失败: $error');
            widget.onFail?.call(error);
          },

          // 广告倒计时结束
          onFinish: () {
            log.info('开屏广告倒计时结束');
            widget.onFinish?.call();
          },

          // 用户点击跳过
          onSkip: () {
            log.info('开屏广告跳过');
            widget.onSkip?.call();
          },

          // 广告加载超时
          onTimeOut: () {
            log.warning('开屏广告超时');
            widget.onTimeOut?.call();
          },
        ),
      ),
    );
  }
}
