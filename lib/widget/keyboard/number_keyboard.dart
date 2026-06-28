import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

import './number_keyboard_config.dart';

// ==================== 数字键盘组件 ====================
class NumberKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final NumberKeyboardConfig? config;
  final VoidCallback? onConfirm;

  const NumberKeyboard({
    super.key,
    required this.controller,
    required this.focusNode,
    this.config,
    this.onConfirm,
  });

  @override
  State<NumberKeyboard> createState() => _NumberKeyboardState();
}

// ==================== 状态管理类 ====================
class _NumberKeyboardState extends State<NumberKeyboard>
    with SingleTickerProviderStateMixin {
  // 成员变量
  late NumberKeyboardConfig _config;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  OverlayEntry? _keyboardOverlay;
  bool _isKeyboardVisible = false;

  // ==================== 生命周期方法 ====================
  @override
  void initState() {
    super.initState();
    _config = widget.config ?? const NumberKeyboardConfig();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.focusNode.removeListener(_onFocusChanged);
    _hideKeyboard();
    super.dispose();
  }

  void _onFocusChanged() {
    if (widget.focusNode.hasFocus) {
      _showKeyboard();
    } else {
      _hideKeyboard();
    }
  }

  // ==================== 键盘显示/隐藏控制 ====================
  void _showKeyboard() {
    if (_isKeyboardVisible || _keyboardOverlay != null) return;

    _isKeyboardVisible = true;
    _animationController.forward();

    _keyboardOverlay = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: _slideAnimation,
          child: _buildKeyboardUI(),
        ),
      ),
    );

    Overlay.of(context).insert(_keyboardOverlay!);
  }

  void _hideKeyboard() {
    if (!_isKeyboardVisible || _keyboardOverlay == null) return;

    _animationController.reverse().then((_) {
      _keyboardOverlay?.remove();
      _keyboardOverlay = null;
      _isKeyboardVisible = false;
    });
  }

  // ==================== 按键处理逻辑 ====================
  void _handleKeyPress(String key) {
    final text = widget.controller.text;

    switch (key) {
      case 'backspace':
        if (text.isNotEmpty) {
          widget.controller.text = text.substring(0, text.length - 1);
        }
        break;

      case 'clear':
        widget.controller.text = '';
        break;

      case 'negative':
        _toggleNegative();
        break;

      case '.':
        if (_config.allowDecimal && !text.contains('.')) {
          if (text.isEmpty || text == '-') {
            widget.controller.text = '${text}0.';
          } else {
            widget.controller.text = '$text.';
          }
        }
        break;

      case 'confirm':
        _confirmInput();
        break;

      default:
        if (text.length < _config.maxLength) {
          if (text == '0') {
            widget.controller.text = key;
          } else {
            widget.controller.text = text + key;
          }
        }
        break;
    }
  }

  // ==================== 辅助方法 ====================
  void _toggleNegative() {
    if (!_config.allowNegative) return;

    final text = widget.controller.text;

    if (text.isEmpty) {
      widget.controller.text = '-';
    } else if (text.startsWith('-')) {
      widget.controller.text = text.substring(1);
    } else {
      widget.controller.text = '-$text';
    }
  }

  void _confirmInput() {
    String value = widget.controller.text.trim();

    if (value == '-' || value == '.') {
      value = '';
    } else if (value.isNotEmpty) {
      if (double.tryParse(value) == null) {
        value = '';
      }
    }

    widget.controller.text = value;

    if (widget.onConfirm != null) {
      widget.onConfirm!();
    }

    widget.focusNode.unfocus();
  }

  // ==================== UI 构建方法 ====================
  Widget _buildKeyboardUI() {
    final themeVars = getCurrentThemeVars(context);
    final colorScheme = getCurrentThemeColorScheme(context);

    return Material(
      color: themeVars.contentBackground,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 300,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildKey('7', themeVars, colorScheme),
                        _buildKey('8', themeVars, colorScheme),
                        _buildKey('9', themeVars, colorScheme),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildKey('4', themeVars, colorScheme),
                        _buildKey('5', themeVars, colorScheme),
                        _buildKey('6', themeVars, colorScheme),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildKey('1', themeVars, colorScheme),
                        _buildKey('2', themeVars, colorScheme),
                        _buildKey('3', themeVars, colorScheme),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        if (_config.allowNegative)
                          _buildKey('negative', themeVars, colorScheme),
                        _buildKey(
                          '0',
                          themeVars,
                          colorScheme,
                          flex: _getZeroFlex(),
                        ),
                        if (_config.allowDecimal)
                          _buildKey('.', themeVars, colorScheme),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildKey(
                      'backspace',
                      themeVars,
                      colorScheme,
                      icon: Icons.backspace,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildKey(
                      'clear',
                      themeVars,
                      colorScheme,
                      textColor: themeVars.dangerColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildConfirmKey(themeVars, colorScheme),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getZeroFlex() {
    int flex = 1;
    if (!_config.allowNegative) flex++;
    if (!_config.allowDecimal) flex++;
    return flex;
  }

  Widget _buildKey(
    String key,
    ThemeVars themeVars,
    ColorScheme colorScheme, {
    IconData? icon,
    Color? textColor,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () => _handleKeyPress(key),
        borderRadius: BorderRadius.circular(themeVars.radius),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: themeVars.scaffoldBackground,
            borderRadius: BorderRadius.circular(themeVars.radius),
          ),
          child: icon != null
              ? Icon(icon, color: textColor ?? themeVars.textColor, size: 24)
              : Text(
                  key == 'negative'
                      ? '-'
                      : key == 'clear'
                      ? 'C'
                      : key,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? themeVars.textColor,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildConfirmKey(ThemeVars themeVars, ColorScheme colorScheme) {
    return InkWell(
      onTap: () => _handleKeyPress('confirm'),
      borderRadius: BorderRadius.circular(themeVars.radius),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        height: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(themeVars.radius),
        ),
        child: Text(
          AppLocalizations.of(context)!.btn_confirm,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ==================== 主构建方法 ====================
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(border: InputBorder.none, isDense: true),
      style: TextStyle(color: getCurrentThemeVars(context).textColor),
    );
  }
}
