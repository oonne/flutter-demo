import 'package:flutter_demo/generated/i18n/app_localizations.dart';

/* 
 * 错误码格式化
 */
String formatErrorCode(AppLocalizations localizations, String errorCode) {
  try {
    final Map<String, String> localizedMap = {
      'status_400': localizations.status_400,
      'status_401': localizations.status_401,
      'status_403': localizations.status_403,
      'status_500': localizations.status_500,
    };
    return localizedMap[errorCode] ?? '';
  } catch (e) {
    return '';
  }
}
