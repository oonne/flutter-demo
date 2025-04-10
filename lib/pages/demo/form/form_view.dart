import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/form_text.dart';
import 'package:flutter_demo/widget/panel/form_input.dart';
import 'package:flutter_demo/widget/panel/form_number_input.dart';
import 'package:flutter_demo/widget/panel/form_switch.dart';
import 'package:flutter_demo/widget/panel/form_date_picker.dart';
import 'package:flutter_demo/widget/panel/form_radio.dart';
import 'package:flutter_demo/widget/panel/form_textarea.dart';

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
   * 销毁
   */
  @override
  void dispose() {
    viewModel.cleanup();
    super.dispose();
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Panel(
                    children: [
                      FormText(label: '纯文本', value: '内容'),
                      FormInput(
                        label: '文本输入框',
                        controller: viewModel.textFieldController,
                        hintText: '请输入内容',
                      ),
                      FormNumberInput(
                        label: '数字输入框',
                        controller: viewModel.numberFieldController,
                        hintText: '请输入数字',
                      ),
                      FormSwitch(
                        label: '开关: ${viewModel.model.switchValue ? '开' : '关'}',
                        switchValue: viewModel.model.switchValue,
                        onChanged: (value) {
                          viewModel.setSwitchValue(value);
                        },
                      ),
                      FormDatePicker(
                        label: '日期选择',
                        dateStr: viewModel.model.dateStr,
                        onChanged: (value) {
                          viewModel.setDateStr(value);
                        },
                      ),
                      FormRadio<String>(
                        label: '性别',
                        selectedValue: viewModel.model.gender,
                        title: '请选择性别',
                        options: [
                          {'value': 'male', 'text': '男'},
                          {'value': 'female', 'text': '女'},
                        ],
                        onChanged: (value) {
                          viewModel.setGender(value);
                        },
                      ),
                      FormTextarea(
                        label: '文本域',
                        controller: viewModel.textareaFieldController,
                        hintText: '请输入内容',
                      ),
                    ],
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
