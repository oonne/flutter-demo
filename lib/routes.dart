import 'package:go_router/go_router.dart';

import 'package:flutter_demo/pages/splash/splash_view.dart';
import 'package:flutter_demo/pages/home/home_view.dart';
import 'package:flutter_demo/pages/demo/demo_view.dart';

/*
 * 路由名称常量
 */
const String splashRoute = '/';
const String homeRoute = '/home';
const String demoRoute = '/demo';

/*
 * 路由表
 */
final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: splashRoute,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: homeRoute,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: demoRoute,
      builder: (context, state) => const DemoView(),
    ),
  ],
);