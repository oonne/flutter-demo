import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * SegmentTabs组件（分段控制器样式）
 * 入参与Tabs组件完全一致：
 * tabs: Tab标题列表
 * selectedIndex: 当前选中的Tab索引
 * onTabChanged: Tab切换回调
 * 
 * 样式说明：
 * - 整体为连续圆角胶囊外容器，仅最左、最右角圆角，中间相邻位置为直角
 * - 选项之间以垂直分割线隔开，无空隙，外框统一浅灰色
 * - 选中项绘制主题色完整边框、文字为主题色；未选中项文字为主题文字色
 * - 内容过长时整个胶囊外容器高度撑开，保证内容完整显示
 */
class SegmentTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  const SegmentTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);
    final colorScheme = getCurrentThemeColorScheme(context);

    final radius = themeVars.radius;
    final borderColor = themeVars.placeholderTextColor;
    final selectedColor = colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: themeVars.contentBackground,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(radius),
          right: Radius.circular(radius),
        ),
        border: Border.all(color: borderColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < tabs.length; i++) ...[
              if (i > 0)
                /* 选项间垂直分割线 */
                Container(width: 1, color: borderColor),
              Expanded(
                child: _buildSegment(i, radius, selectedColor, themeVars),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /* 
   * 单个选项
   */
  Widget _buildSegment(
    int index,
    double radius,
    Color selectedColor,
    ThemeVars themeVars,
  ) {
    final isSelected = index == selectedIndex;
    final isFirst = index == 0;
    final isLast = index == tabs.length - 1;

    /* 选中边框内缩1px，端部圆角跟随外容器 */
    final innerRadius = radius > 1 ? radius - 1 : 0.0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTabChanged(index),
      child: Container(
        margin: isSelected ? const EdgeInsets.all(1) : EdgeInsets.zero,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(isFirst ? innerRadius : 0),
                  right: Radius.circular(isLast ? innerRadius : 0),
                ),
                border: Border.all(color: selectedColor),
              )
            : null,
        child: Text(
          tabs[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? selectedColor : themeVars.textColor,
          ),
        ),
      ),
    );
  }
}
