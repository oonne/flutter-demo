import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 模态弹框
 */
class ModalDialog extends StatelessWidget {
  /// 对话框内容
  final Widget child;
  
  /// 是否显示取消按钮
  final bool showCancelButton;
  
  /// 点击遮罩层是否可以取消
  final bool barrierDismissible;
  
  /// 确定按钮回调
  final VoidCallback? onConfirm;
  
  /// 取消按钮回调
  final VoidCallback? onCancel;
  
  const ModalDialog({
    super.key,
    required this.child,
    this.showCancelButton = true,
    this.barrierDismissible = true,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: barrierDismissible
            ? () => Navigator.of(context).pop()
            : null,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withValues(alpha: 0.5),
          child: GestureDetector(
            onTap: () {}, // 阻止点击事件穿透到子部件
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: themeVars.contentBackground,
                  borderRadius: BorderRadius.circular(themeVars.radius),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /* 
                     * 弹框内容
                     */
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: child,
                    ),

                    /* 
                     * 分割线
                     */
                    const Divider(height: 1),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          if (showCancelButton) ...[
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  if (onCancel != null) {
                                    onCancel!();
                                  }
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('取消'),
                              ),
                            ),
                            const VerticalDivider(width: 1),
                          ],
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                if (onConfirm != null) {
                                  onConfirm!();
                                }
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('确定'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* 
 * 显示模态弹框
 */
Future<T?> showModal<T>({
  required BuildContext context,
  required Widget child,
  bool showCancelButton = true,
  bool barrierDismissible = true,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => ModalDialog(
      showCancelButton: showCancelButton,
      barrierDismissible: barrierDismissible,
      onConfirm: onConfirm,
      onCancel: onCancel,
      child: child,
    ),
  );
} 