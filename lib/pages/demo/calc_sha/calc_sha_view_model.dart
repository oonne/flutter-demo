 import 'package:flutter/material.dart';

import 'package:flutter_demo/utils/message.dart';

import 'calc_sha_model.dart';

class CalcShaViewModel extends ChangeNotifier {
  final CalcShaModel model = CalcShaModel();


  /* 
   * 内容
   */
  final TextEditingController contentTextController = TextEditingController();

  /* 
   * 计算
   */
  Future<void> calc(BuildContext context) async {
    final content = contentTextController.text;
    if (content.isEmpty) {
      showTextSnackBar(context, msg: '内容为空');
      return;
    }
  }
} 