import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';

/* 
 * 扫描错误界面
 */
class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({required this.error, super.key});

  /// 错误
  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = AppLocalizations.of(context)!.msg_scan_permission_denied;
      case MobileScannerErrorCode.unsupported:
        errorMessage =
            AppLocalizations.of(context)!.msg_device_scan_unsupported;
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
        errorMessage = AppLocalizations.of(context)!.msg_scan_failed;
      case MobileScannerErrorCode.controllerAlreadyInitialized:
        errorMessage = 'Controller is already initialized';
        errorMessage = AppLocalizations.of(context)!.msg_scan_failed;
      case MobileScannerErrorCode.controllerDisposed:
        errorMessage = 'Controller is disposed and cannot be used';
        errorMessage = AppLocalizations.of(context)!.msg_scan_failed;
      case MobileScannerErrorCode.genericError:
        errorMessage = AppLocalizations.of(context)!.unknown_error;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icon/warning-fill.svg',
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 64,
              height: 64,
            ),
            Text(errorMessage, style: const TextStyle(color: Colors.white)),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
