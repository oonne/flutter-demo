import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

import 'panel_item.dart';

/* 
 * 面板
 */
class Panel extends StatelessWidget {
  final List<Widget> children;

  const Panel({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return Container(
      margin: EdgeInsets.all(themeVars.panelMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeVars.contentBackground,
        borderRadius: BorderRadius.circular(themeVars.radius),
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final isLast = entry.key == children.length - 1;
          return PanelItem(
            key: ValueKey(entry.key),
            isLast: isLast,
            child: entry.value,
          );
        }).toList(),
      ),
    );
  }
}
