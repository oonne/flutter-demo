import 'package:flutter/material.dart';

import './panel_item.dart';

/* 
 * 表单开关项
 * label: 标签文字
 * value: 开关状态
 * onChanged: 状态改变回调
 */
class FormSwitch extends PanelItem {
  final bool switchValue;
  final ValueChanged<bool> onChanged;

  FormSwitch({
    super.key,
    required super.label,
    required this.switchValue,
    required this.onChanged,
  }) : super(
    labelFlex: 1,
    contentFlex: 3,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height:20,
          child: Transform.scale(
            scale: 0.8,
            child: Switch(
              value: switchValue,
              onChanged: onChanged,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    ),
  );
} 