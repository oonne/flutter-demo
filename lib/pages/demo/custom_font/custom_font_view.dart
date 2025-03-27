import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_font_view_model.dart';

/* 
 * CustomFont页面
 */
class CustomFontView extends StatefulWidget {
  const CustomFontView({super.key});

  @override
  State<CustomFontView> createState() => _CustomFontViewState();
}

class _CustomFontViewState extends State<CustomFontView> {
  late final CustomFontViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = CustomFontViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CustomFontViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('自定义字体')),
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