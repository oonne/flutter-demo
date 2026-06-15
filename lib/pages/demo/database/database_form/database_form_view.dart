import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/form_input.dart';

import 'database_form_view_model.dart';

class DatabaseFormView extends StatefulWidget {
  const DatabaseFormView({super.key});

  @override
  State<DatabaseFormView> createState() => _DatabaseFormViewState();
}

class _DatabaseFormViewState extends State<DatabaseFormView> {
  late final DatabaseFormViewModel viewModel;
  int? _demoId;

  @override
  void initState() {
    super.initState();
    viewModel = DatabaseFormViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      _demoId = queryParameters?['id'] as int?;
      viewModel.init(context, _demoId);
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

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DatabaseFormViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(_demoId != null ? '编辑数据' : '新增数据'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Panel(
                    children: [
                      FormInput(
                        label: '文本字段',
                        controller: viewModel.textFieldController,
                        hintText: '请输入文本内容',
                      ),
                      FormInput(
                        label: '数字字段',
                        controller: viewModel.doubleFieldController,
                        hintText: '请输入数字',
                      ),
                    ],
                  ),
                  SizedBox(height: themeVars.panelMargin),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: themeVars.panelMargin,
                    ),
                    child: Column(
                      children: [
                        // 保存
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => viewModel.save(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                // 加载中
                                if (viewModel.model.isSaving) ...[
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                Text(
                                  AppLocalizations.of(context)!.btn_save,
                                  style: TextStyle(
                                    fontSize: themeVars.buttonLargeFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_demoId != null) ...[
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () => viewModel.delete(context),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    themeVars.radius,
                                  ),
                                ),
                                side: BorderSide(color: themeVars.dangerColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  if (viewModel.model.isSaving) ...[
                                    const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ],
                                  Text(
                                    '删除',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: themeVars.dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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
