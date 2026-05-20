import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_demo/config/config.dart';
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

  /// 广告视图的宽度
  /// 如果不指定，默认为屏幕宽度
  final double? width;

  /// 广告视图的高度
  /// 如果不指定，默认为屏幕高度
  final double? height;

  /// 是否隐藏跳过按钮
  /// - false（默认）：显示跳过按钮，用户可以提前关闭广告
  /// - true：隐藏跳过按钮，必须等广告倒计时结束
  final bool hideSkip;

  /// 广告加载超时时间，单位毫秒
  /// 如果超过此时间广告仍未加载成功，将触发 onTimeOut 回调
  /// 默认值为 3000ms（3秒）
  final int timeout;

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
    this.width,
    this.height,
    this.hideSkip = false,
    this.timeout = 3000,
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
  @override
  Widget build(BuildContext context) {
    // 如果没有指定宽高，则使用屏幕的宽高
    final screenWidth = widget.width ?? MediaQuery.of(context).size.width;
    final screenHeight = widget.height ?? MediaQuery.of(context).size.height;

    // 构建穿山甲SDK的开屏广告视图
    return FlutterUnionadSplashAdView(
      // 平台配置
      androidCodeId: adSplashAndroidCodeId,  // Android广告位ID
      iosCodeId: adSplashIosCodeId,          // iOS广告位ID
      
      // 功能配置
      supportDeepLink: true,      // 是否支持DeepLink深度链接
      width: screenWidth,         // 广告视图宽度
      height: screenHeight,       // 广告视图高度
      hideSkip: widget.hideSkip, // 是否隐藏跳过按钮
      timeout: widget.timeout,    // 超时时间
      
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
    );
  }
}
