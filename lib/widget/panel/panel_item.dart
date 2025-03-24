import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 面板项
 */
class PanelItem extends StatelessWidget {
  final bool isLast;
  final Widget? icon;
  final String label;
  final String? value;
  final bool showArrow;
  final VoidCallback? onTap;

  const PanelItem({
    super.key,
    this.isLast = false,
    this.icon,
    required this.label,
    this.value,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: constraints.maxWidth,
            decoration:
                !isLast
                    ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: themeVars.scaffoldBackground,
                          width: 1,
                        ),
                      ),
                    )
                    : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                // 左侧区域：图标（可选）
                if (icon != null) ...[icon!],

                // 标签文字
                Expanded(
                  flex: 3,
                  child: Text(
                    label,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: themeVars.textColor),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),

                // 右侧区域：值
                if (value != null) ...[
                  Expanded(
                    flex: 2,
                    child: Text(
                      value!,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: themeVars.secondaryTextColor),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],

                // 右侧区域：箭头
                if (showArrow) ...[
                  SvgPicture.asset(
                    'assets/icon/right.svg',
                    colorFilter: ColorFilter.mode(
                      themeVars.textColor,
                      BlendMode.srcIn,
                    ),
                    width: 16,
                    height: 16,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
