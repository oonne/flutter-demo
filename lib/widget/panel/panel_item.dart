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
          child: InkWell(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 左侧区域：图标（可选）
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                
                // 内容区域
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 标签文字
                      Expanded(
                        flex: 3,
                        child: Text(
                          label,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      
                      // 右侧区域：值和箭头
                      if (value != null || showArrow) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (value != null)
                                Flexible(
                                  child: Text(
                                    value!,
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              if (showArrow) ...[
                                if (value != null) const SizedBox(width: 4),
                                SvgPicture.asset(
                                  'assets/icon/right.svg',
                                  colorFilter: ColorFilter.mode(
                                    Color(0xFF343c49),
                                    BlendMode.srcIn,
                                  ),
                                  width: 16,
                                  height: 16,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
