import 'package:flutter/material.dart';
import 'package:flutter_demo/theme/global.dart';

/* 
 * 主题卡片组件
 * 一个演示如何使用全局主题变量的组件
 */
class ThemedCard extends StatelessWidget {
  final Widget child;
  final double? customRadius;
  final EdgeInsetsGeometry? customPadding;
  
  const ThemedCard({
    super.key, 
    required this.child,
    this.customRadius,
    this.customPadding,
  });

  @override
  Widget build(BuildContext context) {
    // 获取当前主题变量
    final themeVars = getCurrentThemeVars(context);
    
    // 使用主题变量设置卡片样式
    return Card(
      color: themeVars.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(customRadius ?? themeVars.radius),
      ),
      margin: EdgeInsets.all(themeVars.cardMargin),
      child: Padding(
        padding: customPadding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
} 