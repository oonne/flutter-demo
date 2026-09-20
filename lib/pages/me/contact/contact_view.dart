import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/alert/alert.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/form_input.dart';
import 'package:flutter_demo/widget/panel/form_radio.dart';
import 'package:flutter_demo/widget/panel/form_textarea.dart';
import 'package:flutter_demo/theme/global.dart';

import 'contact_view_model.dart';

/* 
 * 联系我们页面
 */
class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  late final ContactViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ContactViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }

  /* 
   * 销毁
   */
  @override
  void dispose() {
    viewModel.cleanup();
    super.dispose();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);
    final l10n = AppLocalizations.of(context)!;

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ContactViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(l10n.title_contact_us),
            ), // 联系我们
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Panel(
                    children: [
                      FormRadio<String>(
                        label: l10n.info_contact_label_type, // 需求类型
                        selectedValue: viewModel.model.type,
                        title: l10n.info_contact_select_type, // 请选择类型
                        options: viewModel.getTypeOptions(l10n),
                        onChanged: (value) {
                          viewModel.setType(value);
                        },
                      ),
                      FormTextarea(
                        label: l10n.info_contact_label_details, // 详细说明
                        controller: viewModel.detailsFieldController,
                        hintText: viewModel.getHint(l10n),
                      ),
                      FormInput(
                        label: l10n.info_contact_label_contact, // 联系方式
                        controller: viewModel.contactFieldController,
                        hintText:
                            l10n.info_contact_contact_placeholder, // 手机号/邮箱
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 提交按钮
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: themeVars.panelMargin,
                    ),
                    width: double.infinity,
                    height: themeVars.buttonLargeHeight,
                    child: ElevatedButton(
                      onPressed: viewModel.model.isSubmitting
                          ? null
                          : () {
                              viewModel.submit(context);
                            },
                      child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                // 加载中
                                if (viewModel.model.isSubmitting) ...[
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                Text(
                                  l10n.btn_submit, // 提交
                                  style: TextStyle(
                                    fontSize: themeVars.buttonLargeFontSize,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 邮箱联系提示
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: themeVars.panelMargin,
                    ),
                    child: Alert(
                      type: AlertType.info,
                      text: l10n.info_contact_email_alert(
                        supportEmail,
                      ), // 您也可以直接发邮件与我们联系
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
