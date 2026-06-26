class NumberKeyboardConfig {
  final bool allowDecimal;
  final bool allowNegative;
  final int maxLength;

  const NumberKeyboardConfig({
    this.allowDecimal = true,
    this.allowNegative = false,
    this.maxLength = 10,
  });
}