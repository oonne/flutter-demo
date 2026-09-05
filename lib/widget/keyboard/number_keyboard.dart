import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

import './number_keyboard_config.dart';

/*
 * 数字键盘高度：键盘 UI 占位高度与驱动内容上移的占位高度共用此值
 */
const double kNumberKeyboardHeight = 300;

/*
 * 全局键盘占位高度（0 表示无键盘弹出）
 *
 * 自定义数字键盘通过 Overlay 悬浮在窗口底部弹出，不会触发系统键盘的
 * viewInsets，因此弹出时页面内容不会自动上移，可能遮挡底部输入框。
 * 键盘弹出/收起期间由 NumberKeyboard 驱动该值（0 <-> 键盘高度），
 * 应用根部通过 [NumberKeyboardInsetsScope] 把它合入
 * MediaQuery.viewInsets.bottom，让 Scaffold 内容/底部弹窗等随键盘一起上移
 */
final ValueNotifier<double> numberKeyboardBottomInset = ValueNotifier(0);

/*
 * 应用根级组件：把数字键盘占位高度合入 MediaQuery.viewInsets.bottom。
 * 挂在 MaterialApp.builder 的 Navigator 之上，使键盘弹出期间整棵应用子树
 * 获得与系统键盘一致的底部避让行为；收起后恢复原状
 */
class NumberKeyboardInsetsScope extends StatelessWidget {
  const NumberKeyboardInsetsScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: numberKeyboardBottomInset,
      builder: (context, keyboardInset, child) {
        final mediaQuery = MediaQuery.of(context);
        final viewInsets = mediaQuery.viewInsets;
        return MediaQuery(
          data: mediaQuery.copyWith(
            viewInsets: EdgeInsets.fromLTRB(
              viewInsets.left,
              viewInsets.top,
              viewInsets.right,
              viewInsets.bottom + keyboardInset,
            ),
          ),
          child: child!,
        );
      },
      child: child,
    );
  }
}

/*
 * 自定义数字键盘组件
 *
 * 一个功能完整的数字输入键盘，支持以下特性：
 * - 替代系统键盘，通过 Overlay 浮层显示
 * - 支持小数点、负数输入
 * - 支持退格、清除操作
 * - 平滑的滑入/滑出动画
 * - 弹出时把占位高度合入 viewInsets，页面内容随键盘上移，避免遮挡输入框
 * - 响应式聚焦状态自动显示/隐藏
 *
 * 使用方式：
 * // 创建控制器和焦点节点
 * final TextEditingController _controller = TextEditingController();
 * final FocusNode _focusNode = FocusNode();
 *
 * // 在 build 方法中使用
 * NumberKeyboard(
 *   controller: _controller,
 *   focusNode: _focusNode,
 *   config: NumberKeyboardConfig(
 *     allowDecimal: true,
 *     allowNegative: false,
 *     maxLength: 10,
 *   ),
 *   onConfirm: () {
 *     // 确认输入后的回调
 *     print('输入值: ${_controller.text}');
 *   },
 * )
 *
 * 布局说明：
 * - 左侧3列：数字键 1-9、0、小数点（可选）、负号（可选）
 * - 右侧1列：退格键、清除键、确认键
 *
 * 参数说明：
 * - controller：必填，文本控制器，用于获取和设置输入内容
 * - focusNode：必填，焦点节点，用于控制键盘的显示与隐藏
 * - config：可选，键盘配置，控制是否允许小数、负数及最大输入长度
 * - onConfirm：可选，确认按钮点击回调
 */
class NumberKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final NumberKeyboardConfig? config;
  final VoidCallback? onConfirm;
  final String? confirmText;
  final TextAlign textAlign;

  const NumberKeyboard({
    super.key,
    required this.controller,
    required this.focusNode,
    this.config,
    this.onConfirm,
    this.confirmText,
    this.textAlign = TextAlign.right,
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

  // 全局键盘占位高度驱动：实例序号 + 当前持有者序号
  static int _insetsSeq = 0;
  static int? _insetsOwnerId;
  late final int _insetsId;

  // ==================== 生命周期方法 ====================
  @override
  void initState() {
    super.initState();
    _config = widget.config ?? const NumberKeyboardConfig();

    // 全局键盘占位高度的驱动者序号：避免多个键盘实例动画互相覆盖
    _insetsId = ++_NumberKeyboardState._insetsSeq;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    // 跟随滑入/滑出动画驱动全局占位高度，使内容上移与键盘动画同步
    _animationController.addListener(_onInsetsTick);
    _animationController.addStatusListener(_onAnimationStatusChanged);

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    _animationController.removeListener(_onInsetsTick);
    _animationController.removeStatusListener(_onAnimationStatusChanged);
    // 页面销毁时直接移除键盘浮层并复位全局占位，不再播放收起动画
    _keyboardOverlay?.remove();
    _keyboardOverlay = null;
    _isKeyboardVisible = false;
    if (_insetsOwnerId == _insetsId) {
      _insetsOwnerId = null;
      numberKeyboardBottomInset.value = 0;
    }
    _animationController.dispose();
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

  /*
   * 键盘滑入动画期间同步驱动全局键盘占位高度（0 -> 键盘高度）
   */
  void _onInsetsTick() {
    if (_insetsOwnerId != _insetsId) {
      return;
    }
    numberKeyboardBottomInset.value =
        kNumberKeyboardHeight * _animationController.value;
  }

  /*
   * 键盘完全弹出后，若聚焦输入框仍被键盘遮挡，
   * 滚动其所在滚动区使其可见（内容已在占位高度驱动下上移一帧）
   */
  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_isKeyboardVisible || !widget.focusNode.hasFocus) {
        return;
      }
      final scrollable = context.findAncestorStateOfType<ScrollableState>();
      if (scrollable == null) {
        return;
      }
      Scrollable.ensureVisible(
        context,
        // 仅当输入框底部超出可视区（即被键盘遮挡）时才滚动，使其刚好露出在键盘上方
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    });
  }

  void _showKeyboard() {
    if (_isKeyboardVisible || _keyboardOverlay != null) return;

    _isKeyboardVisible = true;
    // 认领键盘占位驱动：旧的收键盘实例即使仍在播放反向动画也不再写占位值
    _insetsOwnerId = _insetsId;
    numberKeyboardBottomInset.value = 0;
    _animationController.forward();

    _keyboardOverlay = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: _slideAnimation,
          child: _buildKeyboardUI(),
        ),
      ),
    );

    // 固定挂到根级 Overlay：键盘始终悬浮在窗口底部，与注入的
    // viewInsets（0 -> 键盘高度）位置一致；挂在最近 Overlay 在底部导航
    // 等嵌套场景下位置会与占位高度错位
    Overlay.of(context, rootOverlay: true).insert(_keyboardOverlay!);
  }

  void _hideKeyboard() {
    if (!_isKeyboardVisible || _keyboardOverlay == null) return;

    _animationController.reverse().then((_) {
      if (_insetsOwnerId == _insetsId) {
        _insetsOwnerId = null;
        numberKeyboardBottomInset.value = 0;
      }
      _keyboardOverlay?.remove();
      _keyboardOverlay = null;
      _isKeyboardVisible = false;
    });
  }

  // ==================== 按键处理逻辑 ====================
  void _handleKeyPress(String key) {
    final text = widget.controller.text;
    final selection = _getSelection();

    switch (key) {
      case 'backspace':
        if (text.isNotEmpty) {
          if (selection.isCollapsed) {
            if (selection.start > 0) {
              final newText = text.substring(0, selection.start - 1) + text.substring(selection.start);
              widget.controller.text = newText;
              widget.controller.selection = TextSelection(
                baseOffset: selection.start - 1,
                extentOffset: selection.start - 1,
              );
            }
          } else {
            final newText = text.substring(0, selection.start) + text.substring(selection.end);
            widget.controller.text = newText;
            widget.controller.selection = TextSelection(
              baseOffset: selection.start,
              extentOffset: selection.start,
            );
          }
        }
        break;

      case 'clear':
        widget.controller.text = '';
        widget.controller.selection = const TextSelection(baseOffset: 0, extentOffset: 0);
        break;

      case 'negative':
        _toggleNegative();
        break;

      case '.':
        if (_config.allowDecimal && !text.contains('.')) {
          if (text.isEmpty || text == '-') {
            final newText = '${text}0.';
            widget.controller.text = newText;
            widget.controller.selection = TextSelection(
              baseOffset: newText.length,
              extentOffset: newText.length,
            );
          } else {
            final newText = '${text.substring(0, selection.start)}.${text.substring(selection.end)}';
            final newCursor = selection.start + 1;
            widget.controller.text = newText;
            widget.controller.selection = TextSelection(
              baseOffset: newCursor,
              extentOffset: newCursor,
            );
          }
        }
        break;

      case 'confirm':
        _confirmInput();
        break;

      default:
        final selectedLen = selection.end - selection.start;
        if (text.length - selectedLen + 1 <= _config.maxLength) {
          if (text == '0' && selection.isCollapsed && selection.start == 1) {
            widget.controller.text = key;
            widget.controller.selection = const TextSelection(baseOffset: 1, extentOffset: 1);
          } else {
            final newText = '${text.substring(0, selection.start)}$key${text.substring(selection.end)}';
            final newCursor = selection.start + 1;
            widget.controller.text = newText;
            widget.controller.selection = TextSelection(
              baseOffset: newCursor,
              extentOffset: newCursor,
            );
          }
        }
        break;
    }
  }

  TextSelection _getSelection() {
    final selection = widget.controller.selection;
    if (selection.start >= 0 && selection.end >= 0) {
      final base = selection.start < selection.end ? selection.start : selection.end;
      final extent = selection.start < selection.end ? selection.end : selection.start;
      return TextSelection(baseOffset: base, extentOffset: extent);
    }
    final pos = widget.controller.text.length;
    return TextSelection(baseOffset: pos, extentOffset: pos);
  }

  // ==================== 辅助方法 ====================
  void _toggleNegative() {
    if (!_config.allowNegative) return;

    final text = widget.controller.text;
    final selection = _getSelection();

    if (text.isEmpty) {
      widget.controller.text = '-';
      widget.controller.selection = const TextSelection(baseOffset: 1, extentOffset: 1);
    } else if (text.startsWith('-')) {
      widget.controller.text = text.substring(1);
      final newPos = selection.start > 0 ? selection.start - 1 : 0;
      widget.controller.selection = TextSelection(baseOffset: newPos, extentOffset: newPos);
    } else {
      widget.controller.text = '-$text';
      widget.controller.selection = TextSelection(
        baseOffset: selection.start + 1,
        extentOffset: selection.start + 1,
      );
    }
  }

  void _confirmInput() {
    String value = widget.controller.text.trim();

    if (value == '-' || value == '.') {
      value = '';
    } else if (value.isNotEmpty) {
      // 使用 Decimal 校验，保证输入是合法的十进制数
      if (Decimal.tryParse(value) == null) {
        value = '';
      }
    }

    widget.controller.text = value;
    widget.controller.selection = TextSelection(
      baseOffset: value.length,
      extentOffset: value.length,
    );

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
        height: kNumberKeyboardHeight,
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
          widget.confirmText ?? AppLocalizations.of(context)!.btn_confirm,
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
      textAlign: widget.textAlign,
      style: TextStyle(color: getCurrentThemeVars(context).textColor),
    );
  }
}
