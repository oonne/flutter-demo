import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'calc_sha_view_model.dart';

/* 
 * CalcSha页面
 */
class CalcShaView extends StatefulWidget {
  const CalcShaView({super.key});

  @override
  State<CalcShaView> createState() => _CalcShaViewState();
}

class _CalcShaViewState extends State<CalcShaView> {
  late final CalcShaViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = CalcShaViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CalcShaViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('计算SHA')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /* 
                   * 内容
                   */
                  Padding(
                    padding: EdgeInsets.all(themeVars.panelMargin),
                    child: TextField(
                      controller: viewModel.contentTextController,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),

                  /* 
                   * 计算
                   */
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: themeVars.panelMargin),
                    width: double.infinity,
                    height: themeVars.buttonLargeHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.calc(context);
                      },
                      child: Text('计算'),
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
