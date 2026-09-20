import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/message.dart';
import 'package:flutter_demo/widget/modal/modal_dialog.dart';

import 'contact_model.dart';

class ContactViewModel extends ChangeNotifier {
  // 反馈类型列表
  static const List<String> _typeOptions = [
    '功能建议',
    'bug反馈',
    '定制开发',
    '其他',
  ];

  final ContactModel model = ContactModel();
  final TextEditingController detailsFieldController = TextEditingController();
  final TextEditingController contactFieldController = TextEditingController();

  /*
   * 初始化
   */
  void init(BuildContext context) {
  }

  /*
   * 离开页面
   */
  void cleanup() {
    detailsFieldController.dispose();
    contactFieldController.dispose();
  }

  /*
   * 设置类型
   */
  void setType(String value) {
    model.type = value;
    notifyListeners();
  }

  /*
   * 单选选项列表（value 与 text 均为类型文案）
   */
  List<Map<String, Object>> getTypeOptions(AppLocalizations l10n) {
    return _typeOptions
        .map((type) => <String, Object>{'value': type, 'text': type})
        .toList();
  }

  /*
   * 当前类型对应的输入提示
   */
  String getHint(AppLocalizations l10n) {
    switch (model.type) {
      case '功能建议':
        return l10n.info_contact_hint_feature;
      case 'bug反馈':
        return l10n.info_contact_hint_bug;
      case '定制开发':
        return l10n.info_contact_hint_custom;
      default:
        return l10n.info_contact_hint_other; // 其他
    }
  }

  /*
   * 提交：调用飞书自定义机器人 webhook 发送反馈
   * 文档：https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot
   */
  Future<void> submit(BuildContext context) async {
    if (model.isSubmitting) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    final contact = contactFieldController.text.trim();
    if (contact.isEmpty) {
      showTextSnackBar(context, msg: l10n.msg_contact_input_contact); // 请输入联系方式
      return;
    }

    model.isSubmitting = true;
    notifyListeners();

    final details = detailsFieldController.text.trim();
    final detailsDisplay = details.isEmpty ? l10n.info_none : details; // 无

    // 飞书富文本仅支持 zh_cn/en_us/ja_jp 语种标签，其余语种回退 en_us
    final postLang = switch (Localizations.localeOf(context).languageCode) {
      'zh' => 'zh_cn',
      'ja' => 'ja_jp',
      _ => 'en_us',
    };

    // 构造富文本消息体，参考飞书文档「发送富文本消息」示例
    final requestBody = {
      'msg_type': 'post',
      'content': {
        'post': {
          postLang: {
            'title': '联系我们',
            'content': [
              [
                {'tag': 'text', 'text': '需求类型: $model.type'},
              ],
              [
                {
                  'tag': 'text',
                  'text': '详细说明: $detailsDisplay',
                },
              ],
              [
                {
                  'tag': 'text',
                  'text': '联系方式: $contact',
                },
              ],
            ],
          },
        },
      },
    };

    log.finest('🚀联系我们提交请求', requestBody);

    bool success = false;
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: apiTimeOut),
          receiveTimeout: const Duration(seconds: apiTimeOut),
        ),
      );
      final response = await dio.post(
        contactWebhookUrl,
        // 显式 JSON 编码，与文档 curl -d '{...}' 行为一致
        data: jsonEncode(requestBody),
        options: Options(
          // 文档要求显式设置 Content-Type: application/json
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // 响应可能是已解析的 Map，也可能是 String，统一处理
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }
      log.finest('🎉联系我们响应', responseData);

      // 飞书成功返回 {"code": 0, "msg": "success", "data": {}}
      if (responseData is Map && responseData['code'] == 0) {
        success = true;
      }
    } catch (e) {
      log.warning('💥联系我们提交失败', e);
      success = false;
    }

    model.isSubmitting = false;
    notifyListeners();

    if (!context.mounted) {
      return;
    }

    final message = success
        ? l10n.msg_contact_feedback_received // 已收到您的反馈，我们会尽快与您联系
        : l10n.msg_contact_submit_failed; // 提交失败，您可以尝试通过邮箱与我们联系

    await showModal(
      context: context,
      showCancelButton: false,
      child: Text(message),
    );

    if (success && context.mounted) {
      detailsFieldController.clear();
      contactFieldController.clear();
      GoRouter.of(context).pop();
    }
  }
}
