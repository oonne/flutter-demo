import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/bottom_sheet/selection_bottom_sheet.dart';

import './panel_item.dart';

/* 
 * 表单单选项
 * label: 标签文字
 * value: 当前选中的值
 * options: 选项列表，每个选项需要包含 'value' 和 'text' 两个键
 * title: 弹窗标题
 * onChanged: 选择改变回调
 */
class FormRadio<T> extends PanelItem {
  final T selectedValue;
  final List<Map<String, dynamic>> options;
  final String? title;
  final ValueChanged<T> onChanged;

  FormRadio({
    super.key,
    required super.label,
    required this.selectedValue,
    required this.options,
    this.title,
    required this.onChanged,
  }) : super(
         labelFlex: 1,
         contentFlex: 2,
         content: Builder(
           builder: (context) {
             final themeVars = getCurrentThemeVars(context);

             // 获取当前选中项的显示文本
             final selectedOption = options.firstWhere(
               (option) => option['value'] == selectedValue,
               orElse: () => options.first,
             );
             final displayText = selectedOption['text'] as String;

             return InkWell(
               onTap: () async {
                 final result = await SelectionBottomSheet.show<T>(
                   context: context,
                   title: title,
                   options: options,
                   selectedValue: selectedValue,
                 );

                 if (result != null) {
                   onChanged(result);
                 }
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text(
                     displayText,
                     textAlign: TextAlign.right,
                     style: TextStyle(color: themeVars.secondaryTextColor),
                     softWrap: true,
                     overflow: TextOverflow.visible,
                   ),
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
               ),
             );
           },
         ),
       );
}
