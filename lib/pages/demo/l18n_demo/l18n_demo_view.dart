import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l18n_demo_view_model.dart';

/* 
 * L18nDemo页面
 */
class L18nDemoView extends StatefulWidget {
  const L18nDemoView({super.key});

  @override
  State<L18nDemoView> createState() => _L18nDemoViewState();
}

class _L18nDemoViewState extends State<L18nDemoView> {
  late final L18nDemoViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = L18nDemoViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<L18nDemoViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('国际化')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.lang_name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
