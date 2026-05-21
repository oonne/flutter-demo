import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_unionad/bannerad/BannerAdView.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/log.dart';

/// Banner广告组件的回调函数类型定义
/// 用于处理Banner广告的各种事件回调
typedef BannerAdCallback = void Function();

/// Banner广告Widget
/// 
/// Banner广告是一种固定在页面顶部或底部的条形广告，
/// 尺寸相对较小，通常不会遮挡太多内容。
/// 
/// 主要特点：
/// - 尺寸固定（通常为屏幕宽度 x 高度120dp左右）
/// - 持续展示，用户可以随时点击
/// - 通常放在页面底部，作为固定元素
/// - 支持不感兴趣反馈
/// 
/// 使用示例：
/// ```dart
/// BannerAdWidget(
///   width: 600.5,
///   height: 120.5,
///   onShow: () => print('Banner广告展示成功'),
///   onFail: (error) => print('Banner广告加载失败: $error'),
/// )
/// ```
class BannerAdWidget extends StatefulWidget {
  // ==========================================================================
  // 构造函数参数
  // ==========================================================================

  /// 广告展示成功回调
  /// 当广告加载并成功展示时触发
  final BannerAdCallback? onShow;

  /// 广告被点击回调
  /// 当用户点击广告内容时触发
  final BannerAdCallback? onClick;

  /// 用户点击"不感兴趣"回调
  /// 当用户点击广告旁边的"×"按钮表示不感兴趣时触发
  /// 参数为用户选择的原因
  final Function(String)? onDislike;

  /// 广告加载失败回调
  /// 当广告加载过程中发生错误时触发，参数为错误信息
  final Function(String)? onFail;

  // ==========================================================================
  // 构造函数
  // ==========================================================================

  const BannerAdWidget({
    super.key,
    this.onShow,
    this.onClick,
    this.onDislike,
    this.onFail,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

/// Banner广告组件的状态类
/// 
/// 负责构建穿山甲SDK的Banner广告视图
class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = screenWidth * (adBannerHeight / adBannerWidth);
    
    return FlutterUnionadBannerView(
      androidCodeId: adBannerAndroidCodeId,
      iosCodeId: adBannerIosCodeId,
      
      width: screenWidth,
      height: bannerHeight,
      
      // 回调配置
      callBack: FlutterUnionadBannerCallBack(
        // 广告加载成功并展示
        onShow: () {
          log.info('Banner广告加载完成');
          widget.onShow?.call();
        },
        
        // 用户点击"不感兴趣"
        onDislike: (message) {
          log.info('Banner广告不感兴趣: $message');
          widget.onDislike?.call(message);
        },
        
        // 广告加载失败
        onFail: (error) {
          log.warning('Banner广告加载失败: $error');
          widget.onFail?.call(error);
        },
        
        // 广告被点击
        onClick: () {
          log.info('Banner广告点击');
          widget.onClick?.call();
        },
      ),
    );
  }
}
