import 'package:go_router/go_router.dart';

/* 全局 */
import 'package:flutter_demo/layout/bottom_nav_bar.dart';
import 'package:flutter_demo/pages/splash/splash_view.dart';

/* 首页 */
import 'package:flutter_demo/pages/home/home_view.dart';

/* 我的 */
import 'package:flutter_demo/pages/me/me/me_view.dart';
import 'package:flutter_demo/pages/me/setting/setting_view.dart';
import 'package:flutter_demo/pages/me/about/about_view.dart';

/* 登录 */
import 'package:flutter_demo/pages/login/login_view.dart';

/* 扫码 */
import 'package:flutter_demo/pages/scanner/scan/scan_view.dart';
import 'package:flutter_demo/pages/scanner/scan_result/scan_result_view.dart';

/* Demo */
import 'package:flutter_demo/pages/demo/index/index_view.dart';
import 'package:flutter_demo/pages/demo/mvvm/mvvm_view.dart';
import 'package:flutter_demo/pages/demo/eventbus/eventbus_view.dart';
import 'package:flutter_demo/pages/demo/custom_font/custom_font_view.dart';
import 'package:flutter_demo/pages/demo/date_picker/date_picker_view.dart';
import 'package:flutter_demo/pages/demo/req/req_view.dart';
import 'package:flutter_demo/pages/demo/scan_code/scan_code_view.dart';
import 'package:flutter_demo/pages/demo/calc_sha/calc_sha_view.dart';
import 'package:flutter_demo/pages/demo/user_info/user_info_view.dart';
import 'package:flutter_demo/pages/demo/data_list/data_view.dart';
import 'package:flutter_demo/pages/demo/form/form_view.dart';

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
     * 登录
     */
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),

    /* 
     * 扫码
     */
    GoRoute(
      name: 'scan',
      path: '/scan',
      builder: (context, state) => const ScanView(),
    ),
    /* 扫码结果 */
    GoRoute(
      name: 'scan/result',
      path: '/scan/result',
      builder: (context, state) => const ScanResultView(),
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
    /* 自定义字体 */
    GoRoute(
      name: 'demo/custom_font',
      path: '/demo/custom_font',
      builder: (context, state) => const CustomFontView(),
    ),
    /* 日期选择器 */
    GoRoute(
      name: 'demo/date_picker',
      path: '/demo/date_picker',
      builder: (context, state) => const DatePickerView(),
    ),
    /* 网络请求 */
    GoRoute(
      name: 'demo/req',
      path: '/demo/req',
      builder: (context, state) => const ReqView(),
    ),
    /* 扫码 */
    GoRoute(
      name: 'demo/scan_code',
      path: '/demo/scan_code',
      builder: (context, state) => const ScanCodeView(),
    ),
    /* 计算SHA */
    GoRoute(
      name: 'demo/calc_sha',
      path: '/demo/calc_sha',
      builder: (context, state) => const CalcShaView(),
    ),
    /* 用户信息 */
    GoRoute(
      name: 'demo/user_info',
      path: '/demo/user_info',
      builder: (context, state) => const UserInfoView(),
    ),
    /* 数据列表 */
    GoRoute(
      name: 'demo/data_list',
      path: '/demo/data_list',
      builder: (context, state) => const DataListView(),
    ),
    /* 表单 */
    GoRoute(
      name: 'demo/form',
      path: '/demo/form',
      builder: (context, state) => const FormView(),
    ),
  ],
);
