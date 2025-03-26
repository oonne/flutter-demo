import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';
import 'package:flutter_demo/widget/bottom_sheet/selection_bottom_sheet.dart';

import 'setting_view_model.dart';

/* 
 * 设置页面
 */
class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late final SettingViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = SettingViewModel();
    
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
      child: Consumer<SettingViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(title: Text('设置')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /* 标准卡片 */
                  Panel(
                    children: [
                      PanelItem(
                        label: '主题',
                        value: viewModel.themeModeText,
                        showArrow: true,
                        onTap: () {
                          _showThemeModeSelector(context, viewModel);
                        },
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

  /* 
   * 显示主题模式选择器
   */
  Future<void> _showThemeModeSelector(BuildContext context, SettingViewModel viewModel) async {
    // 使用 SelectionBottomSheet 组件
    final result = await SelectionBottomSheet.show<ThemeMode>(
      context: context,
      title: '选择主题模式',
      options: viewModel.themeModeOptions.map((option) {
        return {
          'value': option['mode'],
          'text': option['text'],
        };
      }).toList(),
      selectedValue: viewModel.themeMode,
    );
    
    // 如果用户选择了一个选项
    if (result != null) {
      await viewModel.changeThemeMode(context, result);
    }
  }
} 