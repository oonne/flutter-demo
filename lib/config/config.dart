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

/* 
 * 广告配置
 */

// 穿山甲广告平台的 Android AppID
const String adAndroidAppId = '5827803';
// 穿山甲广告平台的 iOS AppID
const String adIosAppId = '5827803';
// 应用名称
const String adAppName = 'PMS';

// 开屏广告
const String adSplashAndroidCodeId = '896279658';
const String adSplashIosCodeId = '896279658';

// Banner广告 300_150
const String adBannerAndroidCodeId300_150 = '981876707';
const String adBannerIosCodeId300_150 = '981876707';
// Banner广告 300_45
const String adBannerAndroidCodeId300_45 = '982295843';
const String adBannerIosCodeId300_45 = '982295843';