import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

/* 
 * 底导航
 */
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/home.svg',
              colorFilter: ColorFilter.mode(Color(0xFF343c49), BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icon/home-fill.svg',
              colorFilter: ColorFilter.mode(Color(0xFF343c49), BlendMode.srcIn),
            ),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/customer.svg',
              colorFilter: ColorFilter.mode(Color(0xFF343c49), BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icon/customer-fill.svg',
              colorFilter: ColorFilter.mode(Color(0xFF343c49), BlendMode.srcIn),
            ),
            label: '我的',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/demo')) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).pushReplacement('/home');
        break;
      case 1:
        GoRouter.of(context).pushReplacement('/demo');
        break;
    }
  }
}
