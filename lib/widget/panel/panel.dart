import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 面板
 */
class Panel extends StatelessWidget {
  final Widget child;

  const Panel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // 获取当前主题变量
    final themeVars = getCurrentThemeVars(context);

    return Container(
      margin: EdgeInsets.all(themeVars.panelMargin),
      decoration: BoxDecoration(
        color: themeVars.contentBackground,
        borderRadius: BorderRadius.circular(themeVars.radius),
      ),
      child: child,
    );
  }
}
