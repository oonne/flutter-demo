import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/global/state.dart';
import 'scan_model.dart';

// 权限状态回调类型
typedef PermissionCallback = void Function(bool granted);

class ScanViewModel extends ChangeNotifier {
  final ScanModel model = ScanModel();
  final player = AudioPlayer();

  // 权限状态回调
  PermissionCallback? permissionCallback;

  /* 
   * 初始化
   */
  Future<void> init(Map<String, dynamic>? extra) async {
    // 清空扫码结果
    model.result = '';
    // 扫码后是否返回，默认不返回，跳转到结果页
    model.returnAfterScan = extra?['returnAfterScan'] == true;
    
    // 先请求相机权限，再启动扫描
    await _requestCameraPermission();
  }

  /* 
   * 请求相机权限
   */
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    
    if (status.isGranted) {
      log.info('相机权限已授予');
      await controller.start();
      permissionCallback?.call(true);
    } else if (status.isDenied) {
      log.warning('相机权限被拒绝');
      permissionCallback?.call(false);
    } else if (status.isPermanentlyDenied) {
      log.warning('相机权限被永久拒绝');
      permissionCallback?.call(false);
      // 引导用户去设置页面开启权限
      await openAppSettings();
    }
  }

  /* 
   * 离开页面
   */
  Future<void> cleanup() async {
    // 释放扫描器资源
    await controller.dispose();
    // 释放音频播放器资源
    await player.dispose();
  }

  /* 
   * 扫码控制器
   */
  late MobileScannerController controller = initController();

  // 初始化扫码控制器
  MobileScannerController initController() => MobileScannerController(
    autoStart: false, // 禁止自动启动，等待权限授予后手动启动
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

    // 根据全局配置决定是否播放声音
    final globalState = Provider.of<GlobalState>(context, listen: false);
    if (globalState.isSoundEnabled) {
      await player.setSource(AssetSource('audio/di.mp3'));
      await player.resume();
    }
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
