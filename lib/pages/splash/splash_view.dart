import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/modal/modal_dialog.dart';
import 'package:flutter_demo/widget/ad/widgets/splash_ad_widget.dart';

import 'splash_view_model.dart';

/*
 * Splash页面
 */
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewModel _viewModel;

  // 隐私协议弹框是否已展示（避免重建时重复弹出）
  bool _privacyDialogShown = false;

  /*
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel();

    // 执行进入逻辑
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.enter(context);
    });
  }

  /*
   * 弹出用户协议和隐私政策同意弹框
   */
  Future<void> _showPrivacyDialog() async {
    final localizations = AppLocalizations.of(context)!;

    final agreed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PrivacyAgreementDialog(
          onAgree: () => Navigator.of(dialogContext).pop(true),
          onDisagree: () => Navigator.of(dialogContext).pop(false),
        );
      },
    );

    if (!mounted) {
      return;
    }

    // 同意：保存标识并进入首页
    if (agreed == true) {
      await _viewModel.agreePrivacyPolicy(context);
      return;
    }

    // 不同意：二次确认
    final shouldExit = await showModal<bool>(
      context: context,
      barrierDismissible: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          localizations.msg_privacy_exit_confirm, // 您需要同意用户协议和隐私政策后才能使用 Demo应用，确定要退出吗？
          textAlign: TextAlign.center,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    if (shouldExit == true) {
      // 退出应用
      await SystemNavigator.pop();
      return;
    }

    // 返回：重新展示协议弹框
    _showPrivacyDialog();
  }

  /*
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          final localizations = AppLocalizations.of(context)!;

          // 读取到未同意隐私协议时，弹出同意弹框
          if (viewModel.privacyChecked &&
              !viewModel.acceptedPrivacyPolicy &&
              !_privacyDialogShown) {
            _privacyDialogShown = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showPrivacyDialog();
            });
          }

          return Scaffold(
            body: Column(
              children: [
                // 上半部分（占屏幕85%）：已同意协议时加载开屏广告，否则展示品牌占位
                Expanded(
                  flex: 85,
                  child: viewModel.acceptedPrivacyPolicy
                      ? SplashAdWidget(
                          heightFraction: 0.85,
                          onShow: viewModel.onAdShow,
                          onSkip: () => viewModel.onAdSkip(context),
                          onFinish: () => viewModel.onAdFinish(context),
                          onTimeOut: () => viewModel.onAdTimeOut(context),
                          onFail: (error) => viewModel.onAdFail(context, error),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/img/logo.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                localizations.app_name, // Demo应用
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                // 底部Logo和App名称 - 占屏幕15%
                Expanded(
                  flex: 15,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/img/logo.png', width: 24, height: 24),
                            const SizedBox(width: 8),
                            Text(
                              localizations.app_name, // Demo应用
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
 * 用户协议和隐私政策同意弹框
 */
class PrivacyAgreementDialog extends StatefulWidget {
  // 点击同意
  final VoidCallback onAgree;

  // 点击不同意
  final VoidCallback onDisagree;

  const PrivacyAgreementDialog({
    super.key,
    required this.onAgree,
    required this.onDisagree,
  });

  @override
  State<PrivacyAgreementDialog> createState() => _PrivacyAgreementDialogState();
}

class _PrivacyAgreementDialogState extends State<PrivacyAgreementDialog> {
  late final TapGestureRecognizer _userAgreementRecognizer;
  late final TapGestureRecognizer _privacyPolicyRecognizer;

  @override
  void initState() {
    super.initState();
    _userAgreementRecognizer =
        TapGestureRecognizer()..onTap = _openUserAgreement;
    _privacyPolicyRecognizer =
        TapGestureRecognizer()..onTap = _openPrivacyPolicy;
  }

  @override
  void dispose() {
    _userAgreementRecognizer.dispose();
    _privacyPolicyRecognizer.dispose();
    super.dispose();
  }

  /*
   * 协议链接默认英文，仅中文使用中文版链接
   */
  String get _lang =>
      Localizations.localeOf(context).languageCode == 'zh' ? 'zh' : 'en';

  /*
   * 打开用户协议
   */
  void _openUserAgreement() {
    context.pushNamed(
      'webview',
      extra: {
        'title': AppLocalizations.of(context)!.title_user_agreement, // 用户协议
        'url': userAgreementUrls[_lang],
      },
    );
  }

  /*
   * 打开隐私政策
   */
  void _openPrivacyPolicy() {
    context.pushNamed(
      'webview',
      extra: {
        'title': AppLocalizations.of(context)!.title_privacy_policy, // 隐私政策
        'url': privacyPolicyUrls[_lang],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final themeVars = getCurrentThemeVars(context);
    final colorScheme = getCurrentThemeColorScheme(context);

    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          decoration: BoxDecoration(
            color: themeVars.contentBackground,
            borderRadius: BorderRadius.circular(themeVars.radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题
              Text(
                localizations.title_privacy_agreement, // 用户协议与隐私政策
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: themeVars.textColor,
                ),
              ),
              const SizedBox(height: 16),
              // 内容
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: themeVars.textColor,
                  ),
                  children: [
                    // 欢迎使用 Demo应用！在使用本应用前，请您认真阅读并充分理解
                    TextSpan(text: localizations.info_privacy_intro),
                    // 《用户协议》
                    TextSpan(
                      text: localizations.info_privacy_user_agreement,
                      style: TextStyle(color: colorScheme.primary),
                      recognizer: _userAgreementRecognizer,
                    ),
                    // 和
                    TextSpan(text: localizations.info_privacy_and),
                    // 《隐私政策》
                    TextSpan(
                      text: localizations.info_privacy_privacy_policy,
                      style: TextStyle(color: colorScheme.primary),
                      recognizer: _privacyPolicyRecognizer,
                    ),
                    // 我们将严格按照协议内容保护您的个人信息...
                    TextSpan(text: localizations.info_privacy_outro),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // 操作按钮
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextButton(
                        onPressed: widget.onDisagree,
                        style: TextButton.styleFrom(
                          foregroundColor: themeVars.secondaryTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        child: Text(
                          localizations.btn_disagree, // 不同意
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: FilledButton(
                        onPressed: widget.onAgree,
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        child: Text(
                          localizations.btn_agree_and_continue, // 同意并继续
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
