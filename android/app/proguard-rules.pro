# Flutter 相关规则
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# 字节跳动 SDK 相关规则
-dontwarn com.bytedance.component.sdk.annotation.AnyThread
-dontwarn com.bytedance.component.sdk.annotation.CallSuper
-dontwarn com.bytedance.component.sdk.annotation.ColorInt
-dontwarn com.bytedance.component.sdk.annotation.DungeonFlag
-dontwarn com.bytedance.component.sdk.annotation.FloatRange
-dontwarn com.bytedance.component.sdk.annotation.HungeonFlag
-dontwarn com.bytedance.component.sdk.annotation.IntRange
-dontwarn com.bytedance.component.sdk.annotation.Keep
-dontwarn com.bytedance.component.sdk.annotation.MainThread
-dontwarn com.bytedance.component.sdk.annotation.RawRes
-dontwarn com.bytedance.component.sdk.annotation.RequiresApi
-dontwarn com.bytedance.component.sdk.annotation.RestrictTo$Scope
-dontwarn com.bytedance.component.sdk.annotation.RestrictTo
-dontwarn com.bytedance.component.sdk.annotation.UiThread
-dontwarn com.bytedance.component.sdk.annotation.WorkerThread
-dontwarn com.bytedance.embed_dr.OaidVivoImpl$Type
-dontwarn com.bytedance.framwork.core.sdkmonitor.SDKMonitor$IGetExtendParams
-dontwarn com.bytedance.framwork.core.sdkmonitor.SDKMonitor
-dontwarn com.bytedance.framwork.core.sdkmonitor.SDKMonitorUtils
-dontwarn com.bytedance.keva.Keva
-dontwarn com.bytedance.keva.KevaBuilder
-dontwarn com.bytedance.keva.KevaMonitor
-dontwarn com.bytedance.sdk.openadsdk.TTDownloadEventLogger
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.DialogBuilder
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.IDialogStatusChangedListener
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTDownloadAdapter$OnEventLogHandler
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTDownloadVisitor
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTHttpCallback
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTPermissionCallback
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.TTDownloadEventModel

# Google 广告相关规则
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient$Info
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient

# OkHttp 相关规则
-dontwarn okhttp3.Call
-dontwarn okhttp3.Dispatcher
-dontwarn okhttp3.Dns
-dontwarn okhttp3.OkHttpClient$Builder
-dontwarn okhttp3.OkHttpClient
-dontwarn okhttp3.Protocol
-dontwarn okhttp3.Request$Builder
-dontwarn okhttp3.Request
-dontwarn okhttp3.Response
-dontwarn okhttp3.ResponseBody
-dontwarn okhttp3.internal.http2.StreamResetException

# Apache Commons NTP 相关规则
-dontwarn org.apache.commons.net.ntp.NTPUDPClient
-dontwarn org.apache.commons.net.ntp.NtpV3Packet
-dontwarn org.apache.commons.net.ntp.TimeInfo
-dontwarn org.apache.commons.net.ntp.TimeStamp

# Google Play Core 相关规则
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# 保持第三方库的类不被混淆
-keep class com.byazt.** { *; }
-keep class ms.bz.bd.c.** { *; }