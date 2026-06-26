import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';
import 'package:flutter_demo/widget/keyboard/number_keyboard.dart';
import 'package:flutter_demo/widget/keyboard/number_keyboard_config.dart';
import 'package:flutter_demo/utils/message.dart';

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
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<NumberKeyboardViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: const Text('数字键盘示例')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Panel(
                    children: [
                      PanelItem(
                        label: '正整数',
                        content: NumberKeyboard(
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
                      PanelItem(
                        label: '带小数点',
                        content: NumberKeyboard(
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
                      PanelItem(
                        label: '带负数',
                        content: NumberKeyboard(
                          controller: viewModel.negativeController,
                          focusNode: viewModel.negativeFocusNode,
                          config: const NumberKeyboardConfig(
                            allowDecimal: true,
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
                    ],
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
}