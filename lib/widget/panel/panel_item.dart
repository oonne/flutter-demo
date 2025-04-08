import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 面板项
 * isLast: 是否是最后一项，最后一项不显示底部边框
 * icon: 左侧图标
 * label: 标签文字
 * content: 内容区域，如果 content 不为空，则value和showArrow无效
 * value: 右侧值
 * showArrow: 是否显示右侧箭头
 * labelFlex: 标签文字区域宽度
 * contentFlex: 内容区域宽度
 * onTap: 点击事件
 */
class PanelItem extends StatelessWidget {
  final bool isLast;
  final Widget? icon;
  final String label;
  final Widget? content;
  final String? value;
  final bool showArrow;
  final int labelFlex;
  final int contentFlex;
  final VoidCallback? onTap;

  const PanelItem({
    super.key,
    this.isLast = true,
    this.icon,
    required this.label,
    this.content,
    this.value,
    this.showArrow = false,
    this.labelFlex = 3,
    this.contentFlex = 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                    flex: labelFlex,
                    child: Text(
                      label,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: themeVars.textColor),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),

                  // 内容区域
                  if (content != null) ...[
                    Expanded(
                      flex: contentFlex,
                      child: content!,
                    ),
                  ],

                  // 右侧区域：值
                  if (content == null && value != null) ...[
                    Expanded(
                      flex: contentFlex,
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
                  if (content == null && showArrow) ...[
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
          ),
        );
      },
    );
  }
}
