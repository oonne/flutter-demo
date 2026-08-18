import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';
import 'package:flutter_demo/widget/bottom_sheet/selection_bottom_sheet.dart';
import 'package:flutter_demo/utils/message.dart';

import 'image_crop_view_model.dart';

/* 
 * 图片裁剪页面
 */
class ImageCropView extends StatefulWidget {
  const ImageCropView({super.key});

  @override
  State<ImageCropView> createState() => _ImageCropViewState();
}

class _ImageCropViewState extends State<ImageCropView> {
  late final ImageCropViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ImageCropViewModel();
  }

  /* 
   * 选择图片来源
   */
  Future<void> chooseImageSource() async {
    final source = await SelectionBottomSheet.show<ImageSource>(
      context: context,
      title: '选择图片来源',
      options: [
        {'value': ImageSource.camera, 'text': '拍照'},
        {'value': ImageSource.gallery, 'text': '相册'},
      ],
      selectedValue: ImageSource.gallery,
    );

    if (source == null) {
      return;
    }
    await viewModel.pickImage(source);
  }

  /* 
   * 开始裁剪
   * 主题值在构建阶段获取后传入，避免在事件回调中监听Provider
   */
  Future<void> cropImage({
    required ColorScheme colorScheme,
    required ThemeVars themeVars,
    required bool isDark,
  }) async {
    if (viewModel.model.sourcePath == null) {
      showTextSnackBar(context, msg: '请先选择图片');
      return;
    }

    final success = await viewModel.cropImage(
      context: context,
      colorScheme: colorScheme,
      themeVars: themeVars,
      isDark: isDark,
    );
    if (!mounted) {
      return;
    }
    showTextSnackBar(context, msg: success ? '裁剪成功' : '已取消裁剪');
  }

  /* 
   * 格式化文件大小
   */
  String formatSize(int bytes) {
    if (bytes <= 0) {
      return '';
    }
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / 1024 / 1024).toStringAsFixed(2)} MB';
  }

  /* 
   * 图片预览卡片
   */
  Widget buildImageCard({
    required String title,
    required String path,
    String? extraInfo,
  }) {
    final themeVars = getCurrentThemeVars(context);
    final colorScheme = getCurrentThemeColorScheme(context);

    return Container(
      margin: EdgeInsets.only(
        top: themeVars.panelMargin,
        left: themeVars.panelMargin,
        right: themeVars.panelMargin,
      ),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeVars.contentBackground,
        borderRadius: BorderRadius.circular(themeVars.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(color: themeVars.textColor)),
              const Spacer(),
              if (extraInfo != null)
                Text(
                  extraInfo,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(themeVars.radius),
            child: Image.file(
              File(path),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  /* 
   * 裁剪比例选择
   */
  Widget buildAspectRatioSelector(ImageCropViewModel vm) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ImageCropViewModel.aspectRatioOptions.map((preset) {
        final selected = vm.model.aspectRatioPreset == preset;
        return ChoiceChip(
          label: Text(preset.name),
          selected: selected,
          onSelected: (_) => vm.setAspectRatio(preset),
        );
      }).toList(),
    );
  }

  /* 
   * 裁剪样式选择
   */
  Widget buildCropStyleSelector(ImageCropViewModel vm) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ImageCropViewModel.cropStyleOptions.map((style) {
        final selected = vm.model.cropStyle == style;
        return ChoiceChip(
          label: Text(style == CropStyle.rectangle ? '矩形' : '圆形'),
          selected: selected,
          onSelected: (_) => vm.setCropStyle(style),
        );
      }).toList(),
    );
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ImageCropViewModel>(
        builder: (context, viewModel, child) {
          final model = viewModel.model;
          final colorScheme = getCurrentThemeColorScheme(context);
          final themeVars = getCurrentThemeVars(context);
          final isDark = isDarkMode(context);

          return Scaffold(
            appBar: CustomAppBar(title: const Text('图片裁剪')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /* 
                   * 配置面板
                   */
                  Panel(
                    children: [
                      PanelItem(
                        label: '选择图片',
                        showArrow: true,
                        onTap: chooseImageSource,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (model.sourcePath == null)
                              Text(
                                '未选择',
                                style: TextStyle(
                                  color: themeVars.placeholderTextColor,
                                ),
                              )
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  themeVars.radius,
                                ),
                                child: Image.file(
                                  File(model.sourcePath!),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                      ),
                      PanelItem(
                        label: '裁剪比例',
                        footer: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: buildAspectRatioSelector(viewModel),
                        ),
                      ),
                      PanelItem(
                        label: '裁剪样式',
                        footer: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: buildCropStyleSelector(viewModel),
                        ),
                      ),
                      PanelItem(
                        label: '开始裁剪',
                        showArrow: true,
                        onTap: () {
                          cropImage(
                            colorScheme: colorScheme,
                            themeVars: themeVars,
                            isDark: isDark,
                          );
                        },
                      ),
                    ],
                  ),

                  /* 
                   * 原图预览
                   */
                  if (model.sourcePath != null)
                    buildImageCard(
                      title: '原图',
                      path: model.sourcePath!,
                      extraInfo: '大小: ${formatSize(model.sourceSize)}',
                    ),

                  /* 
                   * 裁剪结果预览
                   */
                  if (model.croppedPath != null)
                    buildImageCard(
                      title: '裁剪结果',
                      path: model.croppedPath!,
                      extraInfo: '大小: ${formatSize(model.croppedSize)}',
                    ),

                  // 底部占位
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
