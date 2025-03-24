import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'me_view_model.dart';
import 'package:flutter_demo/components/theme_toggle_button.dart';
import 'package:flutter_demo/components/themed_card.dart';
import 'package:flutter_demo/theme/global.dart';

/* 
 * 个人中心
 */
class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  @override
  Widget build(BuildContext context) {
    // 获取当前主题变量
    final themeVars = getCurrentThemeVars(context);
    
    return ChangeNotifierProvider(
      create: (_) => MeViewModel(),
      child: Consumer<MeViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(
              title: Text('个人中心'),
              actions: [
                // 主题切换按钮
                const ThemeToggleButton(),
                const SizedBox(width: 12),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Center(child: Text('个人中心')),
                  
                  const SizedBox(height: 20),
                  // 使用主题卡片组件
                  ThemedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '主题设置',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('切换主题:'),
                            const Spacer(),
                            const ThemeToggleButton(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('当前卡片圆角: ${themeVars.radius}'),
                        Text('当前卡片边距: ${themeVars.cardMargin}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  // 自定义卡片属性示例
                  ThemedCard(
                    customRadius: 16,
                    customPadding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          '自定义主题卡片',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Text('这是一个自定义圆角和内边距的卡片'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed('demo');
                    },
                    child: const Text('Demo'),
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
