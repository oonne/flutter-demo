import 'package:flutter/material.dart';

/* 
  * 自定义的AppBar
  */
class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key, 
    super.title, // 标题
    super.actions, // 右侧按钮
    super.automaticallyImplyLeading, // 是否自动显示返回按钮
    super.bottom, // 底部
    super.backgroundColor, // 背景色
    super.foregroundColor, // 前景色
    super.elevation, // 阴影
    super.shape, // 形状
    super.iconTheme, // 图标主题
    super.actionsIconTheme, // 右侧按钮图标主题
    super.primary, // 是否使用主色调
    super.centerTitle, // 是否居中显示标题
    super.titleSpacing, // 标题间距
    super.toolbarHeight, // 工具栏高度
    super.leadingWidth, // 左侧按钮宽度
    super.toolbarTextStyle, // 工具栏文本样式
    super.titleTextStyle, // 标题文本样式
    super.forceMaterialTransparency, // 是否强制使用Material透明度
    super.clipBehavior, // 裁剪行为
    Widget? leading, // 左侧按钮
  }) : super(
         leading: leading ?? (automaticallyImplyLeading
             ? Builder(
                 builder: (context) => IconButton(
                   icon: const Icon(Icons.arrow_back_ios_new),
                   onPressed: () {
                     Navigator.of(context).pop();
                   },
                 ),
               )
             : null),
       );
}
