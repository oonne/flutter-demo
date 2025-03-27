import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'eventbus_view_model.dart';

/* 
 * EventBus页面
 */
class EventbusView extends StatefulWidget {
  const EventbusView({super.key});

  @override
  State<EventbusView> createState() => _EventbusViewState();
}

class _EventbusViewState extends State<EventbusView> {
  late final EventbusViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = EventbusViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }

  /* 
   * 离开页面
   */
  @override
  void dispose() {
    viewModel.cleanup();
    super.dispose();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<EventbusViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('事件总线')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      viewModel.sendEvent();
                    },
                    child: const Text('发送事件'),
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
