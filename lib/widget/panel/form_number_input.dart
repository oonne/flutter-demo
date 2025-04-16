import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

import './panel_item.dart';

/* 
 * 数字输入框项
 * label: 标签文字
 * controller: 输入框控制器
 * hintText: 提示文字（可选）
 * decimal: 是否允许输入小数（可选，默认为false）
 */
class FormNumberInput extends PanelItem {
  final TextEditingController controller;
  final String? hintText;
  final bool decimal;
  final bool sign;

  FormNumberInput({
    super.key,
    required super.label,
    required this.controller,
    this.hintText,
    this.decimal = true,
    this.sign = true,
  }) : super(
         labelFlex: 1,
         contentFlex: 2,
         content: Builder(
           builder:
               (context) => TextField(
                 controller: controller,
                 keyboardType: TextInputType.numberWithOptions(
                   decimal: decimal,
                   signed: sign,
                 ),
                 decoration: InputDecoration(
                   hintText:
                       hintText ??
                       AppLocalizations.of(context)!.info_please_input,
                   hintStyle: TextStyle(
                     color: getCurrentThemeVars(context).placeholderTextColor,
                   ),
                   border: InputBorder.none,
                   contentPadding: EdgeInsets.zero,
                   isDense: true,
                 ),
                 textAlign: TextAlign.right,
               ),
         ),
       );
}
