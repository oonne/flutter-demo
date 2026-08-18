import 'package:image_cropper/image_cropper.dart';

/* 
 * 图片裁剪 Model
 */
class ImageCropModel {
  // 原图路径
  String? sourcePath;

  // 裁剪后图片路径
  String? croppedPath;

  // 原图文件大小(字节)
  int sourceSize = 0;

  // 裁剪后文件大小(字节)
  int croppedSize = 0;

  // 选中的裁剪比例
  CropAspectRatioPreset aspectRatioPreset = CropAspectRatioPreset.original;

  // 选中的裁剪样式
  CropStyle cropStyle = CropStyle.rectangle;
}
