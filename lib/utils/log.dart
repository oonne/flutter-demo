import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final log = Logger('Logger');

/* 
 * 初始化日志
 */
void initLog() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: ${record.message} ${record.error ?? ''}';
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(message).forEach((match) => debugPrint(match.group(0)));
  });
}
