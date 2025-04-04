import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'home_view_model.dart';

/* 
 * 首页
 */
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed('login');
                    },
                    child: const Text('登录页'),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
