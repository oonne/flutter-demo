import 'package:flutter/material.dart';

/* 
  * 自定义的AppBar
  */
class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    super.title,
    super.actions,
    super.automaticallyImplyLeading,
    super.bottom,
    super.backgroundColor,
    super.foregroundColor,
    super.elevation,
    super.shape,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary,
    super.centerTitle,
    super.titleSpacing,
    super.toolbarHeight,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.forceMaterialTransparency,
    super.clipBehavior,
    Widget? leading,
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
