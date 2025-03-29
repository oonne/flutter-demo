import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/utils/message.dart';

import 'scan_result_model.dart';

class ScanResultViewModel extends ChangeNotifier {
  final ScanResultModel model = ScanResultModel();

  /* 
   * 初始化
   */
  Future<void> init(Map<String, dynamic>? extra) async {
    resultTextController.text = extra?['result'] ?? '';
    notifyListeners();
  }

  /* 
   * 扫码结果
   */
  final TextEditingController resultTextController = TextEditingController();

  /* 
   * 复制
   */
  Future<void> copy(BuildContext context) async {
    // 内容为空
    if (resultTextController.text.isEmpty) {
      showTextSnackBar(context, msg: AppLocalizations.of(context)!.msg_content_empty);
      return;
    }

    // 复制
    await Clipboard.setData(ClipboardData(text: resultTextController.text));
    if (!context.mounted) {
      return;
    }
    showTextSnackBar(context, msg: AppLocalizations.of(context)!.msg_copied);
  }
}
