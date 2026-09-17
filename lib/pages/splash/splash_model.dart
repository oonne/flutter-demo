class SplashModel {
  // 广告是否已展示
  bool _isAdShown = false;
  bool get isAdShown => _isAdShown;

  // 是否已完成隐私协议读取（区分"尚未读取"和"读取后未同意"）
  bool _privacyChecked = false;
  bool get privacyChecked => _privacyChecked;

  // 是否已同意用户协议和隐私政策
  bool _acceptedPrivacyPolicy = false;
  bool get acceptedPrivacyPolicy => _acceptedPrivacyPolicy;

  // 设置广告展示状态
  void setAdShown(bool value) {
    _isAdShown = value;
  }

  // 设置隐私协议同意状态
  void setAcceptedPrivacyPolicy(bool value) {
    _privacyChecked = true;
    _acceptedPrivacyPolicy = value;
  }
}
