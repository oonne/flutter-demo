import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

import 'panel_item.dart';

/* 
 * 面板
 */
class Panel extends StatelessWidget {
  final List<PanelItem> children;

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
          final index = entry.key;
          final item = entry.value;
          return PanelItem(
            key: item.key,
            isLast: index == children.length - 1,
            icon: item.icon,
            label: item.label,
            value: item.value,
            showArrow: item.showArrow,
            onTap: item.onTap,
          );
        }).toList(),
      ),
    );
  }
}

