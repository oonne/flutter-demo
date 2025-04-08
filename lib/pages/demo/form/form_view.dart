import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/form_text.dart';
import 'package:flutter_demo/widget/panel/form_input.dart';

import 'form_view_model.dart';

/* 
 * 表单页面
 */
class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  late final FormViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = FormViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<FormViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('表单')),
            body: Column(
              children: [
                Panel(children: [
                  FormText(
                    label: '纯文本',
                    value: '内容',
                  ),
                  FormInput(
                    label: '输入框',
                    controller: viewModel.textFieldController,
                    hintText: '请输入内容',
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
