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
 * - 选中项以主题色完整边框直接替换/覆盖容器边框（端部圆角跟随外容器），文字为主题色；未选中项文字为主题文字色
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
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < tabs.length; i++) ...[
              /* 选中项边框会替换相邻的分割线，故不再绘制 */
              if (i > 0 && i - 1 != selectedIndex && i != selectedIndex)
                /* 选项间垂直分割线 */
                Container(width: 1, color: borderColor),
              Expanded(
                child: _buildSegment(i, radius, selectedColor, borderColor, themeVars),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /* 
   * 单个选项
   * 边框直接绘制在容器外沿位置：选中项以主题色完整边框替换容器边框（端部圆角跟随外容器）
   * 未选中项仅绘制容器外沿的浅灰色边框（首项左、末项右、其余仅上下）
   */
  Widget _buildSegment(
    int index,
    double radius,
    Color selectedColor,
    Color borderColor,
    ThemeVars themeVars,
  ) {
    final isSelected = index == selectedIndex;
    final isFirst = index == 0;
    final isLast = index == tabs.length - 1;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTabChanged(index),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isFirst ? radius : 0),
            right: Radius.circular(isLast ? radius : 0),
          ),
          border: isSelected
              ? Border.all(color: selectedColor)
              : Border(
                  top: BorderSide(color: borderColor),
                  bottom: BorderSide(color: borderColor),
                  left: isFirst ? BorderSide(color: borderColor) : BorderSide.none,
                  right: isLast ? BorderSide(color: borderColor) : BorderSide.none,
                ),
        ),
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
