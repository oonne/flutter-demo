import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

import './panel_item.dart';

/* 
 * 表单多选框项
 * label: 标签文字
 * checked: 是否选中
 * onChanged: 选中状态改变回调
 */
class FormCheckbox extends PanelItem {
  final bool checked;
  final ValueChanged<bool> onChanged;

  FormCheckbox({
    super.key,
    required super.label,
    required this.checked,
    required this.onChanged,
  }) : super(
         labelFlex: 1,
         contentFlex: 2,
         onTap: () => onChanged(!checked),
         content: Builder(
           builder: (context) {
             final themeVars = getCurrentThemeVars(context);
             final colorScheme = getCurrentThemeColorScheme(context);

             return Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 AnimatedContainer(
                   duration: const Duration(milliseconds: 200),
                   curve: Curves.easeInOut,
                   width: 22,
                   height: 22,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: checked
                         ? colorScheme.primary
                         : Colors.transparent,
                     border: Border.all(
                       color: checked
                           ? colorScheme.primary
                           : themeVars.secondaryTextColor,
                       width: 1.5,
                     ),
                   ),
                   child: checked
                       ? const Icon(
                           Icons.check,
                           size: 16,
                           color: Colors.white,
                         )
                       : null,
                 ),
               ],
             );
           },
         ),
       );
}
