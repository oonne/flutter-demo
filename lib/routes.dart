import 'package:go_router/go_router.dart';

/* 全局 */
import 'package:flutter_demo/layout/bottom_nav_bar.dart';
import 'package:flutter_demo/pages/splash/splash_view.dart';

/* 首页 */
import 'package:flutter_demo/pages/home/home/home_view.dart';

/* 我的 */
import 'package:flutter_demo/pages/me/me/me_view.dart';

/* Demo */
import 'package:flutter_demo/pages/demo/mvvm/mvvm_view.dart';

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

    /* Demo */
    GoRoute(
      name: 'demo-mvvm',
      path: '/demo/mvvm',
      builder: (context, state) => const MvvmView(),
    ),
  ],
);
