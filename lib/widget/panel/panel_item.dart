import 'package:flutter/material.dart';

/* 
 * 面板项
 */
class PanelItem extends StatelessWidget {
  final Widget child;

  const PanelItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 检查是否是最后一个元素
        final isLastItem =
            (context.findAncestorWidgetOfExactType<Column>() != null ||
                context
                        .findAncestorWidgetOfExactType<Column>()!
                        .children
                        .last ==
                    child);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration:
              !isLastItem
                  ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  )
                  : null,
          child: child,
        );
      },
    );
  }
}
