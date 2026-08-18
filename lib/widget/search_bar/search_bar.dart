import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

/* 
 * 搜索栏
 */
class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String? placeholder;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    this.placeholder,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  /* 
   * 搜索
   */
  void _handleSearch() {
    final query = _controller.text.trim();
    widget.onSearch(query);
  }

  /* 
   * 清空搜索框
   */
  void _clearSearch() {
    _controller.clear();
    _handleSearch();
  }

  /* 
   * 组件
   */
  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    /* 
     * 输入框聚焦或输入框内有文字时为激活态
     */
    final bool isActive = _focusNode.hasFocus || _controller.text.isNotEmpty;

    /* 
     * 边框颜色
     */
    final Color borderColor = themeVars.placeholderTextColor;

    /* 
     * 激活态输入框边框（完整2px）
     */
    final OutlineInputBorder activeInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(themeVars.radius),
        bottomLeft: Radius.circular(themeVars.radius),
      ),
      borderSide: BorderSide(width: 2, color: borderColor),
    );

    return Container(
      padding: EdgeInsets.only(
        left: themeVars.panelMargin,
        right: themeVars.panelMargin,
        bottom: 8,
      ),
      color: themeVars.contentBackground,
      child: Row(
        children: [
          /* 
           * 搜索框
           */
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: TextStyle(fontSize: 16, height: 1.5),
                    decoration: InputDecoration(
                      hintText: widget.placeholder ?? AppLocalizations.of(context)!.info_search,
                      hintStyle: TextStyle(color: borderColor),
                      border: activeInputBorder,
                      enabledBorder: isActive
                          ? activeInputBorder
                          : InputBorder.none,
                      focusedBorder: isActive
                          ? activeInputBorder
                          : InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: themeVars.panelMargin,
                        vertical: 8,
                      ),
                      isDense: true,
                      suffixIcon:
                          _controller.text.isNotEmpty
                              ? IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icon/error-fill.svg',
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    borderColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                onPressed: _clearSearch,
                                padding: EdgeInsets.zero,
                              )
                              : null,
                    ),
                    onSubmitted: (_) => _handleSearch(),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                /* 
                 * 普通态：左侧、上侧、下侧边框（右侧与按钮合并为一体）
                 */
                if (!isActive)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(themeVars.radius),
                            bottomLeft: Radius.circular(themeVars.radius),
                          ),
                          border: Border(
                            left: BorderSide(width: 1, color: borderColor),
                            top: BorderSide(width: 1, color: borderColor),
                            bottom: BorderSide(width: 1, color: borderColor),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          /* 
           * 搜索按钮
           */
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              children: [
                OutlinedButton(
                  onPressed: _handleSearch,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(themeVars.radius),
                        bottomRight: Radius.circular(themeVars.radius),
                      ),
                    ),
                    backgroundColor: isActive
                        ? themeVars.placeholderTextColor
                        : Colors.white,
                    side: BorderSide.none,
                  ),
                  child: SvgPicture.asset(
                    'assets/icon/search.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isActive
                          ? Colors.white
                          : themeVars.placeholderTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                /* 
                 * 普通态：上侧、右侧、下侧边框（与输入框合为一体）
                 */
                if (!isActive)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(themeVars.radius),
                            bottomRight: Radius.circular(themeVars.radius),
                          ),
                          border: Border(
                            top: BorderSide(width: 1, color: borderColor),
                            right: BorderSide(width: 1, color: borderColor),
                            bottom: BorderSide(width: 1, color: borderColor),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
