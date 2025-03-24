import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/theme/global.dart';

/* 
 * 底导航Item
 */
class NavItem {
  final String icon;
  final String activeIcon;
  final String label;
  final String path;

  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.path,
  });
}

/* 
 * 底导航
 */
class ScaffoldWithNavBar extends StatelessWidget {
  ScaffoldWithNavBar({super.key, required this.child});

  // 页面组件
  final Widget child;
  // 底导航Icon大小
  final double iconSize = 24;

  // 底导航配置
  final List<NavItem> _navItems = [
    NavItem(
      icon: 'assets/icon/home.svg',
      activeIcon: 'assets/icon/home-fill.svg',
      label: '首页',
      path: '/home',
    ),
    NavItem(
      icon: 'assets/icon/customer.svg',
      activeIcon: 'assets/icon/customer-fill.svg',
      label: '我的',
      path: '/me',
    ),
  ];

  /* 
   * 计算选中的索引
   */
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    return _navItems.indexWhere((item) => location.startsWith(item.path));
  }

  /* 
   * 点击事件
   */
  void _onItemTapped(int index, BuildContext context) {
    if (index >= 0 && index < _navItems.length) {
      GoRouter.of(context).pushReplacement(_navItems[index].path);
    }
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = getCurrentThemeColorScheme(context);
    final themeVars = getCurrentThemeVars(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems.map((item) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            item.icon,
            colorFilter: ColorFilter.mode(themeVars.textColor, BlendMode.srcIn),
            width: iconSize,
            height: iconSize,
          ),
          activeIcon: SvgPicture.asset(
            item.activeIcon,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
            width: iconSize,
            height: iconSize,
          ),
          label: item.label,
        )).toList(),
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: themeVars.textColor,
      ),
    );
  }
}

