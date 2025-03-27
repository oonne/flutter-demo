import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 单选底部弹框组件
 * 用于展示一个带有标题和选项列表的底部弹框，用户可以从中选择一个选项
 */
class SelectionBottomSheet extends StatelessWidget {
  // 弹框标题
  final String? title;
  // 当前选中的值
  final dynamic selectedValue;

  /* 
   * 选项列表，每个选项需要包含 'value' 和 'text' 两个键
   * value: 选项的值，可以是任意类型
   * text: 选项的显示文本
   */
  final List<Map<String, dynamic>> options;

  const SelectionBottomSheet({
    super.key,
    this.title,
    required this.selectedValue,
    required this.options,
  });

  /* 
   * 构建底部弹框
   */
  @override
  Widget build(BuildContext context) {
    final colorScheme = getCurrentThemeColorScheme(context);
    final themeVars = getCurrentThemeVars(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: themeVars.contentBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(themeVars.radius),
          topRight: Radius.circular(themeVars.radius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],

          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...options.map((option) {
                    final isSelected = option['value'] == selectedValue;
                    return ListTile(
                      title: Text(
                        option['text'],
                        style: TextStyle(
                          color:
                              isSelected
                                  ? colorScheme.primary
                                  : themeVars.textColor,
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, option['value']);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* 
   * 显示单选底部弹框
   * 
   * 参数:
   * - context: 上下文
   * - title: 弹框标题，可选
   * - options: 选项列表，每个选项需要包含 'value' 和 'text' 两个键
   * - selectedValue: 当前选中的值
   * 
   * 返回: Future<T?>，用户选择的值，如果用户取消选择，则返回null
   */
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required List<Map<String, dynamic>> options,
    T? selectedValue,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      builder: (BuildContext context) {
        return SelectionBottomSheet(
          title: title,
          options: options,
          selectedValue: selectedValue,
        );
      },
    );
  }
}
