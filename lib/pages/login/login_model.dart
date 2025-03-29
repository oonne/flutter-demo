class LoginModel {
  // 密码是否可见
  bool isPasswordVisible = false;
  
  // 表单错误信息
  String? nameError;
  String? passwordError;

  // 登录中
  bool isLoading = false;
}
