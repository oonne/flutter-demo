import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';

BoardPickerLanguages _getLanguageConfig(String locale) {
  switch (locale) {
    case 'zh':
      return BoardPickerLanguages(
        locale: 'zh',
        today: '今天',
        tomorrow: '明天',
        now: '现在',
      );
    case 'en':
      return BoardPickerLanguages(
        locale: 'en',
        today: 'Today',
        tomorrow: 'Tomorrow',
        now: 'Now',
      );
    case 'ru':
      return BoardPickerLanguages(
        locale: 'ru',
        today: 'Сегодня',
        tomorrow: 'Завтра',
        now: 'Сейчас',
      );
    case 'fr':
      return BoardPickerLanguages(
        locale: 'fr',
        today: "Aujourd'hui",
        tomorrow: 'Demain',
        now: 'Maintenant',
      );
    case 'es':
      return BoardPickerLanguages(
        locale: 'es',
        today: 'Hoy',
        tomorrow: 'Mañana',
        now: 'Ahora',
      );
    case 'it':
      return BoardPickerLanguages(
        locale: 'it',
        today: 'Oggi',
        tomorrow: 'Domani',
        now: 'Adesso',
      );
    case 'pt':
      return BoardPickerLanguages(
        locale: 'pt',
        today: 'Hoje',
        tomorrow: 'Amanhã',
        now: 'Agora',
      );
    case 'de':
      return BoardPickerLanguages(
        locale: 'de',
        today: 'Heute',
        tomorrow: 'Morgen',
        now: 'Jetzt',
      );
    case 'ja':
      return BoardPickerLanguages(
        locale: 'ja',
        today: '今日',
        tomorrow: '明日',
        now: '今',
      );
    case 'ko':
      return BoardPickerLanguages(
        locale: 'ko',
        today: '오늘',
        tomorrow: '내일',
        now: '지금',
      );
    case 'vi':
      return BoardPickerLanguages(
        locale: 'vi',
        today: 'Hôm nay',
        tomorrow: 'Ngày mai',
        now: 'Bây giờ',
      );
    default:
      return BoardPickerLanguages(
        locale: 'zh',
        today: '今天',
        tomorrow: '明天',
        now: '现在',
      );
  }
}

// 配置
BoardDateTimeOptions getBoardDateTimeOptions(BuildContext context) {
  final locale = Localizations.localeOf(context).languageCode;
  
  return BoardDateTimeOptions(
    languages: _getLanguageConfig(locale),
    showDateButton: false,
  );
}