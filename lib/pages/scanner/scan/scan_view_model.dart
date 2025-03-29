import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/utils/log.dart';
import 'scan_model.dart';

class ScanViewModel extends ChangeNotifier {
  final ScanModel model = ScanModel();

  /* 
   * 初始化
   */
  Future<void> init(Map<String, dynamic>? extra) async {
    // 启动扫码
    unawaited(controller.start());

    model.returnAfterScan = extra?['returnAfterScan'] == true;
  }

  /* 
   * 离开页面
   */
  Future<void> cleanup() async {
    // 释放扫描器资源
    await controller.dispose();
  }

  /* 
   * 扫码控制器
   */
  late MobileScannerController controller = initController();

  // 初始化扫码控制器
  MobileScannerController initController() => MobileScannerController(
    autoStart: true, // 自动开始扫描
  );

  // 扫码回调
  void onDetect(BuildContext context, BarcodeCapture barcode) {
    String result = barcode.barcodes.first.rawValue ?? '';
    if (result.isEmpty) {
      return;
    }

    log.info('扫码结果: $result');

    // 扫码后返回
    if (model.returnAfterScan) {
      GoRouter.of(context).pop(result);
      return;
    }

    // 扫码后跳到结果页面
    GoRouter.of(context).pushNamed('scan/result', extra: {'result': result});
  }
}
