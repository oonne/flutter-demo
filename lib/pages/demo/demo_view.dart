import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'demo_view_model.dart';

/* 
 * DEMO页面
 */
class DemoView extends StatelessWidget {
  const DemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DemoViewModel(),
      child: Consumer<DemoViewModel>(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 