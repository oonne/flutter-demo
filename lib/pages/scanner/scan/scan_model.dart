/*
 * 相机权限状态
 */
enum CameraPermissionState {
  // 尚未申请
  notDetermined,

  // 已授权
  granted,

  // 已拒绝（可再次申请）
  denied,

  // 永久拒绝（需引导到系统设置开启）
  permanentlyDenied,
}

class ScanModel {
  // 扫码后是否返回
  bool returnAfterScan = false;

  // 扫码结果
  String result = '';

  // 相机权限状态
  CameraPermissionState cameraState = CameraPermissionState.notDetermined;
}
