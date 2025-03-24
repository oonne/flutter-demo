import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 面板项
 */
class PanelItem extends StatelessWidget {
  final bool isLast;
  final Widget child;
  
  const PanelItem({
    super.key,
    this.isLast = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          width: constraints.maxWidth,
          decoration: !isLast
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: themeVars.scaffoldBackground, width: 1),
                  ),
                )
              : null,
          child: child,
        );
      },
    );
  }
}
