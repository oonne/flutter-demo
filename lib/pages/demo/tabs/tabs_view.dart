import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/tabs/tabs.dart';
import 'package:flutter_demo/widget/tabs/segment_tabs.dart';

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
          final themeVars = getCurrentThemeVars(context);
          return Scaffold(
            appBar: CustomAppBar(title: const Text('Tabs示例')),
            body: Column(
              children: [
                Tabs(
                  tabs: viewModel.model.tabs,
                  selectedIndex: viewModel.model.selectedIndex,
                  onTabChanged: viewModel.setSelectedIndex,
                ),
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      viewModel.model.tabContents[viewModel.model.selectedIndex],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                /* 分段控制器示例 */
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: themeVars.panelMargin,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '分段控制器',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: themeVars.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SegmentTabs(
                        tabs: viewModel.model.segmentTabs,
                        selectedIndex: viewModel.model.segmentSelectedIndex,
                        onTabChanged: viewModel.setSegmentSelectedIndex,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.model.segmentContents[viewModel.model.segmentSelectedIndex],
                        style: TextStyle(color: themeVars.secondaryTextColor),
                      ),
                    ],
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