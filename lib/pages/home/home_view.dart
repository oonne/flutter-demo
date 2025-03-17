import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/routes.dart';

import 'home_view_model.dart';


/* 
 * 首页
 */
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(viewModel.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.updateTitle('标题已更新');
                    },
                    child: const Text('更新标题'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, demoRoute);
                    },
                    child: const Text('跳转DEMO'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 