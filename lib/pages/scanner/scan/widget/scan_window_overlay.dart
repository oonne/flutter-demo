import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_window_painter.dart';

/* 
 * 绘制扫描窗口镂空效果的遮罩层
 */
class ScanWindowOverlay extends StatelessWidget {
  const ScanWindowOverlay({
    super.key,
    required this.controller,
    required this.scanWindow,
    this.borderColor = Colors.white,
    this.borderRadius = BorderRadius.zero,
    this.borderStrokeCap = StrokeCap.butt,
    this.borderStrokeJoin = StrokeJoin.miter,
    this.borderStyle = PaintingStyle.stroke,
    this.borderWidth = 2.0,
    this.color = const Color(0x80000000),
  });

  /* 
   * 扫描窗口边框的颜色。
   * 默认为 [Colors.white]。
   */
  final Color borderColor;

  /* 
   * 扫描窗口及其边框的圆角半径。
   * 默认为 [BorderRadius.zero]。
   */
  final BorderRadius borderRadius;

  /* 
   * 扫描窗口边框的线帽样式。
   * 默认为 [StrokeCap.butt]。
   */
  final StrokeCap borderStrokeCap;

  /* 
   * 扫描窗口边框的线连接样式。
   * 默认为 [StrokeJoin.miter]。
   */
  final StrokeJoin borderStrokeJoin;

  /* 
   * 扫描窗口边框的绘制样式。
   * 默认为 [PaintingStyle.stroke]。
   */
  final PaintingStyle borderStyle;

  /* 
   * 扫描窗口边框的宽度。
   * 默认为 2.0。
   */
  final double borderWidth;

  /* 
   * 扫描窗口框的颜色。
   * 默认为 50% 透明度的 [Colors.black]。
   */
  final Color color;

  /// 管理相机预览的控制器。
  final MobileScannerController controller;

  /// 遮罩层的扫描窗口。
  final Rect scanWindow;

  @override
  Widget build(BuildContext context) {
    if (scanWindow.isEmpty || scanWindow.isInfinite) {
      return const SizedBox();
    }

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        // 未就绪。
        if (!value.isInitialized ||
            !value.isRunning ||
            value.error != null ||
            value.size.isEmpty) {
          return const SizedBox();
        }

        return CustomPaint(
          // size: value.size, // 使用相机预览的尺寸
          size: MediaQuery.of(context).size, // 使用屏幕的尺寸
          painter: ScanWindowPainter(
            borderColor: borderColor,
            borderRadius: borderRadius,
            borderStrokeCap: borderStrokeCap,
            borderStrokeJoin: borderStrokeJoin,
            borderStyle: borderStyle,
            borderWidth: borderWidth,
            scanWindow: scanWindow,
            color: color,
          ),
        );
      },
    );
  }
}
