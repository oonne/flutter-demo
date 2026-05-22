class SplashModel {
  // 广告是否已展示
  bool _isAdShown = false;
  bool get isAdShown => _isAdShown;

  // 设置广告展示状态
  void setAdShown(bool value) {
    _isAdShown = value;
  }
} 