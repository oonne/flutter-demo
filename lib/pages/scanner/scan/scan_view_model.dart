import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_model.dart';

class ScanViewModel extends ChangeNotifier {
  final ScanModel model = ScanModel();

  /* 
   * 初始化
   */
  Future<void> init() async {
    // 启动扫码
    unawaited(controller.start());
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
  void onDetect(BarcodeCapture barcode) {
    debugPrint('扫码结果: ${barcode.barcodes.first.rawValue}');
  }
}
