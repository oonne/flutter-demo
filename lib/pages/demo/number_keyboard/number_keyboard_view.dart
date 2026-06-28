import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/keyboard/number_keyboard.dart';
import 'package:flutter_demo/widget/keyboard/number_keyboard_config.dart';
import 'package:flutter_demo/utils/message.dart';
import 'package:flutter_demo/theme/global.dart';

import 'number_keyboard_view_model.dart';

class NumberKeyboardView extends StatefulWidget {
  const NumberKeyboardView({super.key});

  @override
  State<NumberKeyboardView> createState() => _NumberKeyboardViewState();
}

class _NumberKeyboardViewState extends State<NumberKeyboardView> {
  late final NumberKeyboardViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = NumberKeyboardViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      viewModel.init(queryParameters);
    });
  }

  @override
  void dispose() {
    viewModel.cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);
    final colorScheme = getCurrentThemeColorScheme(context);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<NumberKeyboardViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: const Text('数字键盘示例')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '正整数',
                    style: TextStyle(
                      color: themeVars.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildKeyboardContainer(
                    themeVars: themeVars,
                    colorScheme: colorScheme,
                    focusNode: viewModel.integerFocusNode,
                    child: NumberKeyboard(
                      controller: viewModel.integerController,
                      focusNode: viewModel.integerFocusNode,
                      config: const NumberKeyboardConfig(
                        allowDecimal: false,
                        allowNegative: false,
                      ),
                      onConfirm: () {
                        showTextSnackBar(
                          context,
                          msg: '正整数输入: ${viewModel.integerController.text}',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '带小数点',
                    style: TextStyle(
                      color: themeVars.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildKeyboardContainer(
                    themeVars: themeVars,
                    colorScheme: colorScheme,
                    focusNode: viewModel.decimalFocusNode,
                    child: NumberKeyboard(
                      controller: viewModel.decimalController,
                      focusNode: viewModel.decimalFocusNode,
                      config: const NumberKeyboardConfig(
                        allowDecimal: true,
                        allowNegative: false,
                      ),
                      onConfirm: () {
                        showTextSnackBar(
                          context,
                          msg: '小数输入: ${viewModel.decimalController.text}',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '带负数',
                    style: TextStyle(
                      color: themeVars.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildKeyboardContainer(
                    themeVars: themeVars,
                    colorScheme: colorScheme,
                    focusNode: viewModel.negativeFocusNode,
                    child: NumberKeyboard(
                      controller: viewModel.negativeController,
                      focusNode: viewModel.negativeFocusNode,
                      config: const NumberKeyboardConfig(
                        allowDecimal: false,
                        allowNegative: true,
                      ),
                      onConfirm: () {
                        showTextSnackBar(
                          context,
                          msg: '负数输入: ${viewModel.negativeController.text}',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '带小数点和负号',
                    style: TextStyle(
                      color: themeVars.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildKeyboardContainer(
                    themeVars: themeVars,
                    colorScheme: colorScheme,
                    focusNode: viewModel.decimalNegativeFocusNode,
                    child: NumberKeyboard(
                      controller: viewModel.decimalNegativeController,
                      focusNode: viewModel.decimalNegativeFocusNode,
                      config: const NumberKeyboardConfig(
                        allowDecimal: true,
                        allowNegative: true,
                      ),
                      onConfirm: () {
                        showTextSnackBar(
                          context,
                          msg: '小数负数输入: ${viewModel.decimalNegativeController.text}',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('返回'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKeyboardContainer({
    required ThemeVars themeVars,
    required ColorScheme colorScheme,
    required FocusNode focusNode,
    required Widget child,
  }) {
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(themeVars.panelMargin),
          decoration: BoxDecoration(
            color: themeVars.contentBackground,
            borderRadius: BorderRadius.circular(themeVars.radius),
            border: Border.all(
              color: focusNode.hasFocus
                  ? colorScheme.primary
                  : colorScheme.outline,
              width: focusNode.hasFocus ? 2 : 1,
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}