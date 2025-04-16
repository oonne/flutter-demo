import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

import './panel_item.dart';

/* 
 * 表单输入框项
 * label: 标签文字
 * controller: 输入框控制器
 * hintText: 提示文字（可选）
 */
class FormInput extends PanelItem {
  final TextEditingController controller;
  final String? hintText;

  FormInput({
    super.key,
    required super.label,
    required this.controller,
    this.hintText,
  }) : super(
         labelFlex: 1,
         contentFlex: 2,
         content: Builder(
           builder:
               (context) => TextField(
                 controller: controller,
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
                 maxLines: null,
                 textAlign: TextAlign.right,
               ),
         ),
       );
}
