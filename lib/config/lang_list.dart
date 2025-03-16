import 'package:flutter/material.dart';

/* 
 * 支持的语言
 */
List<dynamic> langList = [
  {
    'code': 'zh_CN',
    'name': '简体中文',
    'languageCode': 'zh',
    'scriptCode': null,
  },
  {
    'code': 'zh_TW',
    'name': '繁體中文',
    'languageCode': 'zh',
    'scriptCode': 'Hant',
  },
  {
    'code': 'en_US',
    'name': 'English',
    'languageCode': 'en',
    'scriptCode': null,
  },
  {
    'code': 'ru_RU',
    'name': 'Русский',
    'languageCode': 'ru',
    'scriptCode': null,
  },
  {
    'code': 'fr_FR',
    'name': 'Français',
    'languageCode': 'fr',
    'scriptCode': null,
  },
  {
    'code': 'es_ES',
    'name': 'Español',
    'languageCode': 'es',
    'scriptCode': null,
  },
  {
    'code': 'it_IT',
    'name': 'Italiano',
    'languageCode': 'it',
    'scriptCode': null,
  },
  {
    'code': 'pt_PT',
    'name': 'Português',
    'languageCode': 'pt',
    'scriptCode': null,
  },
  {
    'code': 'de_DE',
    'name': 'Deutsch',
    'languageCode': 'de',
    'scriptCode': null,
  },
  {
    'code': 'ja_JP',
    'name': '日本語',
    'languageCode': 'ja',
    'scriptCode': null,
  },
  {
    'code': 'ko_KR',
    'name': '한국어',
    'languageCode': 'ko',
    'scriptCode': null,
  },
  {
    'code': 'vi_VN',
    'name': 'Tiếng Việt',
    'languageCode': 'vi',
    'scriptCode': null,
  },
];

/* 
 * Code 转 languageCode 和 scriptCode
 */
Map<String, dynamic> getLanguageCode(String code) {
  Locale locale = Locale.fromSubtags(languageCode: 'zh');
  var languageCode = locale.languageCode;
  var scriptCode = locale.scriptCode;
  String newCode = code;

  if (code.contains('en')) {
    languageCode = 'en';
    scriptCode = null;
    newCode = 'en_US';
  }
  if (code.contains('ru')) {
    languageCode = 'ru';
    scriptCode = null;
    newCode = 'ru_RU';
  }
  if (code.contains('fr')) {
    languageCode = 'fr';
    scriptCode = null;
    newCode = 'fr_FR';
  }
  if (code.contains('es')) {
    languageCode = 'es';
    scriptCode = null;
    newCode = 'es_ES';
  }
  if (code.contains('de')) {
    languageCode = 'de';
    scriptCode = null;
    newCode = 'de_DE';
  }
  if (code.contains('it')) {
    languageCode = 'it';
    scriptCode = null;
    newCode = 'it_IT';
  }
  if (code.contains('pt')) {
    languageCode = 'pt';
    scriptCode = null;
    newCode = 'pt_PT';
  }
  if (code.contains('ja')) {
    languageCode = 'ja';
    scriptCode = null;
    newCode = 'ja_JP';
  }
  if (code.contains('ko')) {
    languageCode = 'ko';
    scriptCode = null;
    newCode = 'ko_KR';
  }
  if (code.contains('vi')) {
    languageCode = 'vi';
    scriptCode = null;
    newCode = 'vi_VN';
  }
  if (code.contains('zh')) {
    languageCode = 'zh';
    scriptCode = null;
    newCode = 'zh_CN';
  }
  if (code.contains('zh') &&
      (code.contains('Hant') || code.contains('HK') || code.contains('TW'))) {
    languageCode = 'zh';
    scriptCode = 'Hant';
    newCode = 'zh_TW';
  }

  return {
    'languageCode': languageCode,
    'scriptCode': scriptCode,
    'code': newCode,
  };
}
