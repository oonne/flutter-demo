import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';
import 'package:flutter_demo/widget/panel/form_text.dart';

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
                    label: '内容',
                    value: '123',
                  ),
                  PanelItem(
                    label: '输入框',
                    labelFlex: 1,
                    contentFlex: 3,
                    content: TextField(
                      decoration: InputDecoration(
                        hintText: '请输入内容',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      maxLines: null,
                      textAlign: TextAlign.right,
                    ),
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
