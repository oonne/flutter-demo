import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/global/state.dart';

import 'index_view_model.dart';

/* 
 * Demo
 */
class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: true);

    return ChangeNotifierProvider(
      create: (_) => IndexViewModel(),
      child: Consumer<IndexViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(title: Text('Demo')),
            body: Column(
              children: [
                /* Mvvm示例 */
                const SizedBox(height: 20, width: double.infinity),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed('demo/mvvm', extra: {'num': 123});
                  },
                  child: const Text('Mvvm示例'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
