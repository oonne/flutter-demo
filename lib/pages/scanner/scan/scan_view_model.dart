import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_model.dart';

class ScanViewModel extends ChangeNotifier {
  final ScanModel model = ScanModel();

  /* 
   * 扫码控制器
   */
  late MobileScannerController controller = initController();

  // 初始化扫码控制器
  MobileScannerController initController() => MobileScannerController(
    autoStart: true, // 自动开始扫描
  );
}
