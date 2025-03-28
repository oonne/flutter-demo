import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/generated/error_code.dart';

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

/* 
 * 获取请求返回体的本地化错误消息
 */
String getErrorMessage(BuildContext context, Map<String, dynamic> err) {
  final errorCode = err['code'];
  final errorMessage = err['message'];

  if (errorCode == null) {
    return errorMessage;
  }

  final localizations = AppLocalizations.of(context);
  if (localizations == null) {
    return errorMessage;
  }

  final formattedErrorCode = formatErrorCode(localizations, errorCode);
  if (formattedErrorCode == '') {
    return errorMessage;
  }

  return formattedErrorCode;
}
