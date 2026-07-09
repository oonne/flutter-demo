import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * Tabs组件
 * tabs: Tab标题列表
 * selectedIndex: 当前选中的Tab索引
 * onTabChanged: Tab切换回调
 */
class Tabs extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  const Tabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    _tabController.addListener(_onTabChange);
  }

  @override
  void didUpdateWidget(covariant Tabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.selectedIndex,
      );
      _tabController.addListener(_onTabChange);
    }
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  void _onTabChange() {
    if (_tabController.indexIsChanging) {
      widget.onTabChanged(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);
    final colorScheme = getCurrentThemeColorScheme(context);

    return Container(
      color: themeVars.contentBackground,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.symmetric(horizontal: themeVars.panelMargin),
            labelPadding: const EdgeInsets.only(right: 16),
            labelColor: colorScheme.primary,
            unselectedLabelColor: themeVars.secondaryTextColor,
            indicatorColor: colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.label,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            dividerColor: Colors.transparent,
            tabs: widget.tabs.map((tab) {
              return Tab(text: tab);
            }).toList(),
          ),
        ],
      ),
    );
  }
}