import 'package:go_router/go_router.dart';

import 'package:flutter_demo/pages/splash/splash_view.dart';
import 'package:flutter_demo/pages/home/home_view.dart';
import 'package:flutter_demo/pages/demo/demo_view.dart';

/*
 * 路由表
 */
final router = GoRouter(
  routes: <RouteBase>[
    /* 启动页 */
    GoRoute(
      path: '/',
      redirect: (context, state) => '/splash',
    ),

    /* 闪屏 */
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashView(),
    ),

    /* 首页 */
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),

    /* 测试 */
    GoRoute(
      name: 'demo',
      path: '/demo',
      builder: (context, state) => const DemoView(),
    ),
  ],
);