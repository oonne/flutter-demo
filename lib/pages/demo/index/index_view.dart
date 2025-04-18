import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';

import 'index_view_model.dart';

/* 
 * Demo
 */
class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  late final IndexViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = IndexViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<IndexViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('Demo')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /* 标准卡片 */
                  Panel(
                    children: [
                      PanelItem(
                        label: 'Mvvm示例',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/mvvm', extra: {'num': 123});
                        },
                      ),
                      PanelItem(
                        label: '事件总线',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/eventbus');
                        },
                      ),
                      PanelItem(
                        label: '自定义字体',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/custom_font');
                        },
                      ),
                      PanelItem(
                        label: '日期选择器',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/date_picker');
                        },
                      ),
                      PanelItem(
                        label: '网络请求',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/req');
                        },
                      ),
                      PanelItem(
                        label: '扫码',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/scan_code');
                        },
                      ),
                      PanelItem(
                        label: '计算SHA',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/calc_sha');
                        },
                      ),
                      PanelItem(
                        label: '用户信息',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/user_info');
                        },
                      ),
                      PanelItem(
                        label: '数据列表',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/data_list');
                        },
                      ),
                      PanelItem(
                        label: '表单',
                        showArrow: true,
                        onTap: () {
                          context.pushNamed('demo/form');
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
}
