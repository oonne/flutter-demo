import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_demo/utils/log.dart';
import 'scan_model.dart';

class ScanViewModel extends ChangeNotifier {
  final ScanModel model = ScanModel();
  final player = AudioPlayer();

  /* 
   * 初始化
   */
  Future<void> init(Map<String, dynamic>? extra) async {
    // 清空扫码结果
    model.result = '';
    // 启动扫码
    unawaited(controller.start());
    // 扫码后是否返回，默认不返回，跳转到结果页
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

  /* 
   * 扫码回调
   */
  Future<void> onDetect(BuildContext context, BarcodeCapture barcode) async {
    // 防止重复触发
    if (model.result.isNotEmpty) {
      return;
    }

    String result = barcode.barcodes.first.rawValue ?? '';
    if (result.isEmpty) {
      return;
    }

    model.result = result;
    log.info('扫码结果: $result');

    // 播放声音
    await player.setSource(AssetSource('audio/di.mp3'));
    await player.resume();
    if (!context.mounted) {
      return;
    }

      // 扫码后返回
    if (model.returnAfterScan) {
      GoRouter.of(context).pop(result);
      return;
    }

    // 扫码后跳到结果页面
    GoRouter.of(context).pushReplacementNamed('scan/result', extra: {'result': result});
  }
}
