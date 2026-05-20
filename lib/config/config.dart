/* 
 * 全局的配置文件
 */
// 超时时间
const int apiTimeOut = 30;
const int uploadTimeOut = 60;

// token刷新时间
const int tokenRefreshTime = 1000 * 60 * 60 * 12;
// 登录pow计算位数
const int loginPowLength = 4;

// 分页
const int pageSize = 10;

// ==========================================================================
// 广告配置
// ==========================================================================

// 穿山甲广告平台的 Android AppID
const String adAndroidAppId = '5098580';
// 穿山甲广告平台的 iOS AppID
const String adIosAppId = '5098580';
// 应用名称
const String adAppName = 'flutter_demo';

// 是否为生产环境
const bool adIsProduction = false;
// 是否使用GroMore聚合功能
const bool adUseMediation = false;

// 开屏广告
const String adSplashAndroidCodeId = '102729400';
const String adSplashIosCodeId = '102729400';

// Banner广告
const String adBannerAndroidCodeId = '102735527';
const String adBannerIosCodeId = '102735527';