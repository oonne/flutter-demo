import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/search_bar/search_bar.dart';
import 'package:flutter_demo/widget/data_list/data_list_view.dart';
import 'package:flutter_demo/database/database.dart';

import 'database_list_view_model.dart';

class DatabaseListView extends StatefulWidget {
  const DatabaseListView({super.key});

  @override
  State<DatabaseListView> createState() => _DatabaseListViewState();
}

class _DatabaseListViewState extends State<DatabaseListView> {
  late final DatabaseListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DatabaseListViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.refresh(context);
    });
  }

  void _handleSearch(String keyword) {
    viewModel.setSearchKeyword(keyword);
    viewModel.refresh(context);
  }

  void _handleItemTap(Demo? item) {
    context.pushNamed('demo/database_form', extra: {'id': item?.id}).then((_) {
      viewModel.refresh(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DatabaseListViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: const Text('数据库示例'),
              actions: [
                IconButton(
                  onPressed: () async {
                    final result = await GoRouter.of(
                      context,
                    ).pushNamed('demo/database_form');

                    if (result != null) {
                      final Map<String, dynamic> resultMap =
                          result as Map<String, dynamic>;
                      if (resultMap['refresh'] == true && context.mounted) {
                        viewModel.refresh(context);
                      }
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/icon/add.svg',
                    colorFilter: ColorFilter.mode(
                      themeVars.textColor,
                      BlendMode.srcIn,
                    ),
                    width: 28,
                    height: 28,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                /* 搜索栏 */
                Container(
                  padding: EdgeInsets.only(
                    left: themeVars.panelMargin,
                    right: themeVars.panelMargin,
                    bottom: 8,
                  ),
                  color: themeVars.contentBackground,
                  child: CustomSearchBar(onSearch: _handleSearch),
                ),
                Expanded(
                  child: EasyRefreshDataList(
                    dataList: viewModel.model.dataList,
                    itemBuilder: (context, item, index) {
                      return InkWell(
                        onTap: () => _handleItemTap(item),
                        child: Container(
                          padding: EdgeInsets.all(themeVars.panelMargin),
                          margin: EdgeInsets.symmetric(
                            horizontal: themeVars.panelMargin,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: themeVars.contentBackground,
                            borderRadius: BorderRadius.circular(
                              themeVars.radius,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.demoTextField ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeVars.textColor,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${item?.demoDoubleField ?? ''}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: themeVars.secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    isEmpty: viewModel.model.isEmpty,
                    onRefresh: () async {
                      await viewModel.refresh(context);
                    },
                    onLoad: () async {
                      await viewModel.loadMore(context);
                    },
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
