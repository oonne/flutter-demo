import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/routes.dart';

/* 
 * 主函数
 */
Future<void> main() async {
  // 确保 Flutter binding 初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化日志
  initLog();

  // 读取环境
  final prefs = await SharedPreferences.getInstance();
  String env = prefs.getString('ENV') ?? '';
  if (env == '' || env == 'prod') {
    await dotenv.load(fileName: ".env");
  } else {
    await dotenv.load(fileName: ".env.$env");
  }
  String envName = dotenv.env['ENV_NAME'] ?? '';
  log.info("准备启动 环境: $envName");
  
  // 初始化全局状态
  final globalState = GlobalState();
  await globalState.initThemeMode();

  // 启动应用
  runApp(MainApp(globalState: globalState));
}

/* 
 * 主应用
 */
class MainApp extends StatelessWidget {
  final GlobalState globalState;
  
  const MainApp({super.key, required this.globalState});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: globalState,
      child: Consumer<GlobalState>(
        builder: (context, state, _) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: getLightThemeData(),
            darkTheme: getDarkThemeData(),
          );
        },
      ),
    );
  }
}
