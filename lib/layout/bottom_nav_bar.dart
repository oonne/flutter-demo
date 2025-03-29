import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
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
  const ScaffoldWithNavBar({super.key, required this.child});

  // 页面组件
  final Widget child;
  // 底导航Icon大小
  final double iconSize = 24;

  /* 
   * 底导航配置
   */
  List<NavItem> _getNavItems(BuildContext context) {
    return [
      // 首页
      NavItem(
        icon: 'assets/icon/home.svg',
        activeIcon: 'assets/icon/home-fill.svg',
        label: AppLocalizations.of(context)!.title_home,
        path: '/home',
      ),
      // 我的
      NavItem(
        icon: 'assets/icon/customer.svg',
        activeIcon: 'assets/icon/customer-fill.svg',
        label: AppLocalizations.of(context)!.title_me,
        path: '/me',
      ),
    ];
  }

  /* 
   * 计算选中的索引
   */
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    final navItems = _getNavItems(context);
    return navItems.indexWhere((item) => location.startsWith(item.path));
  }

  /* 
   * 点击事件
   */
  void _onItemTapped(int index, BuildContext context) {
    final navItems = _getNavItems(context);
    if (index >= 0 && index < navItems.length) {
      GoRouter.of(context).pushReplacement(navItems[index].path);
    }
  }

  /* 
   * 构建组件
   */
  @override
  Widget build(BuildContext context) {
    final colorScheme = getCurrentThemeColorScheme(context);
    final themeVars = getCurrentThemeVars(context);
    final navItems = _getNavItems(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: navItems.map((item) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            item.icon,
            colorFilter: ColorFilter.mode(themeVars.secondaryTextColor, BlendMode.srcIn),
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
        unselectedItemColor: themeVars.secondaryTextColor,
      ),
    );
  }
}

