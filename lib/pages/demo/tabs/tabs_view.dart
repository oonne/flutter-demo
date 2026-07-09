import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/tabs/tabs.dart';

import 'tabs_view_model.dart';

/* 
 * Tabs示例页面
 */
class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  late final TabsViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = TabsViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(null);
    });
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<TabsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: const Text('Tabs示例')),
            body: Column(
              children: [
                Tabs(
                  tabs: viewModel.model.tabs,
                  selectedIndex: viewModel.model.selectedIndex,
                  onTabChanged: viewModel.setSelectedIndex,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      viewModel.model.tabContents[viewModel.model.selectedIndex],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}