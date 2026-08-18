import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter_demo/theme/global.dart';

import 'image_crop_model.dart';

/* 
 * 图片裁剪 ViewModel
 */
class ImageCropViewModel extends ChangeNotifier {
  final ImageCropModel model = ImageCropModel();
  final ImagePicker imagePicker = ImagePicker();

  // 裁剪比例选项
  static const List<CropAspectRatioPreset> aspectRatioOptions = [
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ];

  // 裁剪样式选项
  static const List<CropStyle> cropStyleOptions = [
    CropStyle.rectangle,
    CropStyle.circle,
  ];

  /* 
   * 选择图片
   */
  Future<void> pickImage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image == null) {
      return;
    }

    model.sourcePath = image.path;
    model.sourceSize = await File(image.path).length();
    // 重新选择图片后清空裁剪结果
    model.croppedPath = null;
    model.croppedSize = 0;
    notifyListeners();
  }

  /* 
   * 设置裁剪比例
   */
  void setAspectRatio(CropAspectRatioPreset preset) {
    model.aspectRatioPreset = preset;
    notifyListeners();
  }

  /* 
   * 设置裁剪样式
   */
  void setCropStyle(CropStyle style) {
    model.cropStyle = style;
    notifyListeners();
  }

  /* 
   * 打开裁剪页面
   * 主题相关参数在View构建阶段获取后传入，避免在事件回调中监听Provider
   * 返回是否裁剪成功
   */
  Future<bool> cropImage({
    required BuildContext context,
    required ColorScheme colorScheme,
    required ThemeVars themeVars,
    required bool isDark,
  }) async {
    final sourcePath = model.sourcePath;
    if (sourcePath == null) {
      return false;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '图片裁剪',
          toolbarColor: colorScheme.primary,
          toolbarWidgetColor: Colors.white,
          backgroundColor: themeVars.scaffoldBackground,
          statusBarLight: !isDark,
          initAspectRatio: model.aspectRatioPreset,
          lockAspectRatio: false,
          cropStyle: model.cropStyle,
          aspectRatioPresets: aspectRatioOptions,
        ),
        IOSUiSettings(
          title: '图片裁剪',
          doneButtonTitle: '完成',
          cancelButtonTitle: '取消',
          cropStyle: model.cropStyle,
          aspectRatioPresets: aspectRatioOptions,
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.page,
        ),
      ],
    );

    if (croppedFile == null) {
      return false;
    }

    model.croppedPath = croppedFile.path;
    model.croppedSize = await File(croppedFile.path).length();
    notifyListeners();
    return true;
  }
}
