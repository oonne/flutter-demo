import 'package:flutter/material.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

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

  try {
    // 使用Map获取本地化字符串
    final Map<String, String> localizedMap = {
      'status_400': localizations.status_400,
      'status_401': localizations.status_401,
      'status_403': localizations.status_403,
      'status_500': localizations.status_500,
    };
    return localizedMap[errorCode] ?? errorMessage;
  } catch (e) {
    return errorMessage;
  }
}
