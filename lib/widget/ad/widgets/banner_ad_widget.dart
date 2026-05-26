import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_unionad/bannerad/BannerAdView.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/widget/ad/platform_ad_config.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/global/state.dart';

/// Banner广告组件的回调函数类型定义
/// 用于处理Banner广告的各种事件回调
typedef BannerAdCallback = void Function();

/// Banner广告尺寸标识枚举
enum BannerAdSize {
  size300_150('300_150'),
  size300_45('300_45'),
  ;

  const BannerAdSize(this.value);
  final String value;
}

/// Banner广告尺寸配置映射
/// 尺寸标识 -> (宽度, 高度)
const Map<String, (double, double)> bannerAdSizeMap = {
  '300_150': (300.0, 150.0),
  '300_45': (300.0, 45.0),
};

String getBannerCodeId(String sizeKey) {
  switch (sizeKey) {
    case '300_150':
      return PlatformAdConfig.bannerCodeId300_150;
    case '300_45':
      return PlatformAdConfig.bannerCodeId300_45;
    default:
      return PlatformAdConfig.bannerCodeId300_150;
  }
}

/// Banner广告Widget
/// 
/// Banner广告是一种固定在页面顶部或底部的条形广告，
/// 尺寸相对较小，通常不会遮挡太多内容。
/// 
/// 主要特点：
/// - 尺寸根据bannerSize参数动态确定
/// - 持续展示，用户可以随时点击
/// - 通常放在页面底部，作为固定元素
/// - 支持不感兴趣反馈
/// 
/// 使用示例：
/// ```dart
/// BannerAdWidget(
///   bannerSize: BannerAdSize.size300_150,
///   onShow: () => print('Banner广告展示成功'),
///   onFail: (error) => print('Banner广告加载失败: $error'),
/// )
/// ```
class BannerAdWidget extends StatefulWidget {
  // ==========================================================================
  // 构造函数参数
  // ==========================================================================

  /// Banner广告尺寸标识
  /// 用于确定广告的尺寸和对应的代码位
  final BannerAdSize bannerSize;

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
    required this.bannerSize,
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
    return Consumer<GlobalState>(
      builder: (context, globalState, child) {
        // 如果全局配置不显示广告，则返回空组件
        if (!globalState.isShowAd) {
          return const SizedBox.shrink();
        }
        
        final screenWidth = MediaQuery.of(context).size.width;
        final sizeKey = widget.bannerSize.value;
        
        // 获取尺寸配置
        final sizeConfig = bannerAdSizeMap[sizeKey];
        if (sizeConfig == null) {
          log.warning('Banner广告尺寸配置不存在: $sizeKey');
          return const SizedBox.shrink();
        }
        final (width, height) = sizeConfig;
        final bannerHeight = screenWidth * (height / width);
        
        // 获取代码位配置
        final codeId = getBannerCodeId(sizeKey);
        
        return FlutterUnionadBannerView(
          androidCodeId: codeId,
          iosCodeId: codeId,
          
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
      },
    );
  }
}
