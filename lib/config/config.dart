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

/// 客服邮箱
const String supportEmail = 'support@runawaystar.com';
// 联系我们webhook地址
const String contactWebhookUrl = 'https://open.feishu.cn/open-apis/bot/v2/hook/9e71b79e-5f37-42ae-bc99-3f374744a61f';

// 用户协议（默认英文，中文使用 zh）
const Map<String, String> userAgreementUrls = {
  'zh': 'https://any-print.com/piconfc/user_agreement.html',
  'en': 'https://any-print.com/piconfc/user_agreement_en.html',
};
// 隐私政策（默认英文，中文使用 zh）
const Map<String, String> privacyPolicyUrls = {
  'zh': 'https://any-print.com/piconfc/privacy_policy.html',
  'en': 'https://any-print.com/piconfc/privacy_policy_en.html',
};
// 更新日志（默认英文，中文使用 zh）
const Map<String, String> updateLogUrls = {
  'zh': 'https://any-print.com/piconfc/app/changelog.html',
  'en': 'https://any-print.com/piconfc/app/changelog_en.html',
};


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

/// iOS 广告配置
const AdConfig adIosConfig = AdConfig(
  appId: '', // 应用id
  splashCodeId: '', // 开屏广告代码位ID
  bannerCodeId300_150: '', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);

/// Android GooglePlay 广告配置
const AdConfig adGoogleplayConfig = AdConfig(
  appId: '5827803', // 应用id
  splashCodeId: '896279658', // 开屏广告代码位ID
  bannerCodeId300_150: '981876707', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);

/// Android Xiaomi 广告配置
const AdConfig adXiaomiConfig = AdConfig(
  appId: '', // 应用id
  splashCodeId: '', // 开屏广告代码位ID
  bannerCodeId300_150: '', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);

/// Android Oppo 广告配置
const AdConfig adOppoConfig = AdConfig(
  appId: '', // 应用id
  splashCodeId: '', // 开屏广告代码位ID
  bannerCodeId300_150: '', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);

/// Android Vivo 广告配置
const AdConfig adVivoConfig = AdConfig(
  appId: '', // 应用id
  splashCodeId: '', // 开屏广告代码位ID
  bannerCodeId300_150: '', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);

/// Android Honor 广告配置
const AdConfig adHonorConfig = AdConfig(
  appId: '', // 应用id
  splashCodeId: '', // 开屏广告代码位ID
  bannerCodeId300_150: '', // Banner 300x150
  bannerCodeId300_45: '', // Banner 300x45
);
