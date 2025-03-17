import 'package:flutter/material.dart';

import 'package:flutter_demo/pages/home/home_view.dart';
import 'package:flutter_demo/pages/demo/demo_view.dart';

/*
 * 路由名称常量
 */
const String homeRoute = '/home';
const String demoRoute = '/demo';

/*
 * 路由表
 */
final Map<String, WidgetBuilder> routes = {
  homeRoute: (context) => const HomeView(),
  demoRoute: (context) => const DemoView(),
};
