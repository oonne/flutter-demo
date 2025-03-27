import 'package:flutter/material.dart';

/* 
 * 纯文本SnackBar
 */
void showTextSnackBar(
  BuildContext context, {
  required String msg,
  Duration? duration,
  bool showClose = false,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: duration ?? const Duration(seconds: 2),
      action: showClose ? SnackBarAction(label: '关闭', onPressed: () {}) : null,
    ),
  );
}
