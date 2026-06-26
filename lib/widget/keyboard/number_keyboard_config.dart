class NumberKeyboardConfig {
  final bool allowDecimal;
  final bool allowNegative;
  final int maxLength;

  const NumberKeyboardConfig({
    // 是否显示小数点
    this.allowDecimal = true,
    // 是否显示负号
    this.allowNegative = false,
    // 最大长度
    this.maxLength = 10,
  });
}