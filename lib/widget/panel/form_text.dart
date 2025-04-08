import './panel_item.dart';

/* 
 * 表单文本项
 * label: 标签文字
 * value: 右侧值
 * showArrow: 是否显示右侧箭头
 */
class FormText extends PanelItem {
  const FormText({
    super.key,
    required super.label,
    required super.value,
    super.showArrow = false,
  }) : super(
    labelFlex: 1,
    contentFlex: 2,
  );
} 