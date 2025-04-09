import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/datetime_picker/datetime_picker.dart';

import './panel_item.dart';

/* 
 * 表单日期选择项
 * label: 标签文字
 * value: 当前日期字符串 (格式：yyyy-MM-dd)
 * onChanged: 日期改变回调 (格式：yyyy-MM-dd)
 */
class FormDatePicker extends PanelItem {
  final String dateStr;
  final ValueChanged<String> onChanged;

  FormDatePicker({
    super.key,
    required super.label,
    required this.dateStr,
    required this.onChanged,
  }) : super(
         labelFlex: 1,
         contentFlex: 2,
         content: Builder(
           builder: (context) {
             final themeVars = getCurrentThemeVars(context);
             return InkWell(
               onTap: () async {
                 final result = await showBoardDateTimePicker(
                   context: context,
                   pickerType: DateTimePickerType.date,
                   initialDate: DateTime.parse(dateStr),
                   minimumDate: DateTime(2015, 1, 1),
                   maximumDate: DateTime(2093, 1, 1),
                   options: getBoardDateTimeOptions(context),
                 );

                 if (result != null) {
                   final dateStr = formatDate(result, [yyyy, '-', mm, '-', dd]);
                   onChanged(dateStr);
                 }
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text(
                     dateStr,
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
