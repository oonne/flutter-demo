import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
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
                  TextField(
                    controller: viewModel.integerController,
                    focusNode: viewModel.integerFocusNode,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      labelText: '正整数',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NumberKeyboard(
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
                  const SizedBox(height: 30),
                  TextField(
                    controller: viewModel.decimalController,
                    focusNode: viewModel.decimalFocusNode,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      labelText: '带小数点',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NumberKeyboard(
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
                  const SizedBox(height: 30),
                  TextField(
                    controller: viewModel.negativeController,
                    focusNode: viewModel.negativeFocusNode,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      labelText: '带负数',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NumberKeyboard(
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
                  const SizedBox(height: 30),
                  TextField(
                    controller: viewModel.decimalNegativeController,
                    focusNode: viewModel.decimalNegativeFocusNode,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      labelText: '带小数点和负号',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NumberKeyboard(
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