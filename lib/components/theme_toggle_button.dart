import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/global/state.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    final isDark = globalState.isDarkMode || 
      (globalState.themeMode == ThemeMode.system && 
       MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    return IconButton(
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        globalState.toggleThemeMode();
      },
      tooltip: isDark ? '切换到浅色模式' : '切换到深色模式',
    );
  }
} 