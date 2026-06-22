import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/global.dart';

enum AlertType {
  success,
  info,
  warning,
  error,
}

class Alert extends StatelessWidget {
  final String text;
  final AlertType type;
  final EdgeInsetsGeometry? padding;

  const Alert({
    super.key,
    required this.text,
    this.type = AlertType.info,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);
    
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(themeVars.radius),
        border: Border.all(
          color: _getBorderColor(context),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: _getTextColor(context),
          fontSize: 16,
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDark = isDarkMode(context);
    
    switch (type) {
      case AlertType.success:
        return isDark 
            ? const Color.fromRGBO(20, 50, 20, 0.5) 
            : const Color.fromRGBO(230, 255, 230, 1);
      case AlertType.info:
        return isDark 
            ? const Color.fromRGBO(20, 30, 60, 0.5) 
            : const Color.fromRGBO(230, 240, 255, 1);
      case AlertType.warning:
        return isDark 
            ? const Color.fromRGBO(60, 50, 20, 0.5) 
            : const Color.fromRGBO(255, 250, 230, 1);
      case AlertType.error:
        return isDark 
            ? const Color.fromRGBO(60, 20, 20, 0.5) 
            : const Color.fromRGBO(255, 230, 230, 1);
    }
  }

  Color _getBorderColor(BuildContext context) {
    final isDark = isDarkMode(context);
    
    switch (type) {
      case AlertType.success:
        return isDark 
            ? const Color.fromRGBO(40, 100, 40, 0.8) 
            : const Color.fromRGBO(150, 220, 150, 1);
      case AlertType.info:
        return isDark 
            ? const Color.fromRGBO(40, 60, 120, 0.8) 
            : const Color.fromRGBO(150, 180, 230, 1);
      case AlertType.warning:
        return isDark 
            ? const Color.fromRGBO(120, 100, 40, 0.8) 
            : const Color.fromRGBO(220, 200, 120, 1);
      case AlertType.error:
        return isDark 
            ? const Color.fromRGBO(120, 40, 40, 0.8) 
            : const Color.fromRGBO(220, 150, 150, 1);
    }
  }

  Color _getTextColor(BuildContext context) {
    final isDark = isDarkMode(context);
    
    switch (type) {
      case AlertType.success:
        return isDark 
            ? const Color.fromRGBO(100, 255, 100, 1) 
            : const Color.fromRGBO(20, 100, 20, 1);
      case AlertType.info:
        return isDark 
            ? const Color.fromRGBO(100, 150, 255, 1) 
            : const Color.fromRGBO(20, 60, 120, 1);
      case AlertType.warning:
        return isDark 
            ? const Color.fromRGBO(255, 220, 100, 1) 
            : const Color.fromRGBO(120, 90, 20, 1);
      case AlertType.error:
        return isDark 
            ? const Color.fromRGBO(255, 100, 100, 1) 
            : const Color.fromRGBO(120, 20, 20, 1);
    }
  }
}