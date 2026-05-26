/*
 * 全局的配置文件
 */
/// HTTP请求超时时间（秒）
const int apiTimeOut = 30;
/// 文件上传超时时间（秒）
const int uploadTimeOut = 60;


/// Token刷新时间间隔（毫秒）
const int tokenRefreshTime = 1000 * 60 * 60 * 12;
/// 登录Pow（工作量证明）计算位数
const int loginPowLength = 4;

/// 默认分页大小
const int pageSize = 10;

/* 
 * 广告配置
 */

/// 应用名称
const String adAppName = 'PMS';

/// 广告配置类
class AdConfig {
  final String appId;
  final String splashCodeId;
  final String bannerCodeId300_150;
  final String bannerCodeId300_45;

  const AdConfig({
    required this.appId,
    required this.splashCodeId,
    required this.bannerCodeId300_150,
    required this.bannerCodeId300_45,
  });
}

/// Android 广告配置
const AdConfig adAndroidConfig = AdConfig(
  appId: '5827803', // 应用id
  splashCodeId: '896279658', // 开屏广告代码位ID
  bannerCodeId300_150: '981876707', // Banner 300x150
  bannerCodeId300_45: '982295843', // Banner 300x45
);

/// iOS 广告配置
const AdConfig adIosConfig = AdConfig(
  appId: '', // 应用id
  splashCodeId: '', // 开屏广告代码位ID
  bannerCodeId300_150: '', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);
