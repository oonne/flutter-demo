import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';

class CustomRefreshHeader extends ClassicHeader {
  CustomRefreshHeader(BuildContext context)
      : super(
          dragText: AppLocalizations.of(context)!.info_pull_down_refresh, // 下拉时显示的文字
          armedText: AppLocalizations.of(context)!.info_release_refresh, // 达到触发距离时显示的文字
          readyText: AppLocalizations.of(context)!.info_start_refresh, // 释放时显示的文字
          processingText: AppLocalizations.of(context)!.info_refreshing, // 刷新中显示的文字
          processedText: AppLocalizations.of(context)!.info_refresh_complete, // 刷新完成显示的文字
          noMoreText: AppLocalizations.of(context)!.info_no_more_data, // 没有更多数据时显示的文字
          failedText: AppLocalizations.of(context)!.info_refresh_failed, // 刷新失败时显示的文字
          messageText: AppLocalizations.of(context)!.info_last_updated, // 可以显示更新时间
        );
}

class CustomRefreshFooter extends ClassicFooter {
  CustomRefreshFooter(BuildContext context)
      : super(
          dragText: AppLocalizations.of(context)!.info_pull_up_load, // 上拉时显示的文字
          armedText: AppLocalizations.of(context)!.info_release_load, // 达到触发距离时显示的文字
          readyText: AppLocalizations.of(context)!.info_start_load, // 释放时显示的文字
          processingText: AppLocalizations.of(context)!.info_loading, // 加载中显示的文字
          processedText: AppLocalizations.of(context)!.info_load_complete, // 加载完成显示的文字
          noMoreText: AppLocalizations.of(context)!.info_no_more_data, // 没有更多数据时显示的文字
          failedText: AppLocalizations.of(context)!.info_load_failed, // 加载失败时显示的文字
          messageText: AppLocalizations.of(context)!.info_last_updated, // 可以显示更新时间
        );
}