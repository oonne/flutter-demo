import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_model.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeModel()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: const _HomeViewContent(),
    );
  }
}

class _HomeViewContent extends StatelessWidget {
  const _HomeViewContent();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);
    final controller = Provider.of<HomeController>(context);
    

    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateDescription('描述已被更新！');
              },
              child: const Text('更新描述'),
            ),
          ],
        ),
      ),
    );
  }
} 