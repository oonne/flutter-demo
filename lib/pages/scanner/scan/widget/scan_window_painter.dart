import 'package:flutter/material.dart';

/* 
 * 绘制扫描窗口矩形的 [CustomPainter]。
 */
class ScanWindowPainter extends CustomPainter {
  const ScanWindowPainter({
    required this.borderColor,
    required this.borderRadius,
    required this.borderStrokeCap,
    required this.borderStrokeJoin,
    required this.borderStyle,
    required this.borderWidth,
    required this.color,
    required this.scanWindow,
  });

  /// 扫描窗口边框的颜色。
  final Color borderColor;

  /// 扫描窗口及其边框的圆角半径。
  final BorderRadius borderRadius;

  /// 扫描窗口边框的线条端点样式。
  final StrokeCap borderStrokeCap;

  /// 扫描窗口边框的线条连接样式。
  final StrokeJoin borderStrokeJoin;

  /// 扫描窗口边框的绘制样式。
  final PaintingStyle borderStyle;

  /// 扫描窗口边框的宽度。
  final double borderWidth;

  /// 扫描窗口框的颜色。
  final Color color;

  /// 定义扫描窗口的矩形区域。
  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    if (scanWindow.isEmpty || scanWindow.isInfinite) {
      return;
    }

    // 定义覆盖整个屏幕的主遮罩路径。
    final backgroundPath = Path()..addRect(Offset.zero & size);

    // 根据圆角半径定义裁剪矩形。
    final RRect cutoutRect = borderRadius == BorderRadius.zero
        ? RRect.fromRectAndCorners(scanWindow)
        : RRect.fromRectAndCorners(
            scanWindow,
            topLeft: borderRadius.topLeft,
            topRight: borderRadius.topRight,
            bottomLeft: borderRadius.bottomLeft,
            bottomRight: borderRadius.bottomRight,
          );

    // 裁剪路径始终在中心。
    final Path cutoutPath = Path()..addRRect(cutoutRect);

    // 组合两个路径：遮罩减去裁剪区域
    final Path overlayWithCutoutPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final Paint overlayWithCutoutPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver; // android

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = borderStyle
      ..strokeWidth = borderWidth
      ..strokeCap = borderStrokeCap
      ..strokeJoin = borderStrokeJoin;

    // 绘制带裁剪的遮罩。
    canvas.drawPath(overlayWithCutoutPath, overlayWithCutoutPaint);

    // 然后，在裁剪区域周围绘制边框。
    canvas.drawRRect(cutoutRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScanWindowPainter oldDelegate) {
    return oldDelegate.scanWindow != scanWindow ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}
