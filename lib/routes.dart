import 'package:go_router/go_router.dart';

/* 全局 */
import 'package:flutter_demo/layout/bottom_nav_bar.dart';
import 'package:flutter_demo/pages/splash/splash_view.dart';

/* 首页 */
import 'package:flutter_demo/pages/home/home/home_view.dart';

/* 我的 */
import 'package:flutter_demo/pages/me/me/me_view.dart';
import 'package:flutter_demo/pages/me/setting/setting_view.dart';
import 'package:flutter_demo/pages/me/about/about_view.dart';

/* Demo */
import 'package:flutter_demo/pages/demo/index/index_view.dart';
import 'package:flutter_demo/pages/demo/mvvm/mvvm_view.dart';
import 'package:flutter_demo/pages/demo/eventbus/eventbus_view.dart';
/*
 * 路由表
 */
final router = GoRouter(
  routes: <RouteBase>[
    /*
     * 启动页
     */
    GoRoute(path: '/', redirect: (context, state) => '/splash'),
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashView(),
    ),

    /* 
     * 底导航
     */
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        /* 首页 */
        GoRoute(
          name: 'home',
          path: '/home',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const HomeView(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return child;
              },
            );
          },
        ),
        /* 我的 */
        GoRoute(
          name: 'me',
          path: '/me',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const MeView(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return child;
              },
            );
          },
        ),
      ],
    ),

    /* 
     * 个人中心
     */
    /* 设置 */
    GoRoute(
      name: 'me/setting',
      path: '/me/setting',
      builder: (context, state) => const SettingView(),
    ),
    /* 关于 */
    GoRoute(
      name: 'me/about',
      path: '/me/about',
      builder: (context, state) => const AboutView(),
    ),

    /* 
     * Demo
     */
    GoRoute(
      name: 'demo',
      path: '/demo',
      builder: (context, state) => const IndexView(),
    ),
    /* MVVM */
    GoRoute(
      name: 'demo/mvvm',
      path: '/demo/mvvm',
      builder: (context, state) => const MvvmView(),
    ),
    /* 事件总线 */
    GoRoute(
      name: 'demo/eventbus',
      path: '/demo/eventbus',
      builder: (context, state) => const EventbusView(),
    ),
  ],
);
