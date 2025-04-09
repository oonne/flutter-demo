import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

/* 
 * 搜索栏
 */
class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  // 边框颜色
  final Color borderColor = Colors.grey.shade400;

  @override
  void dispose() {
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
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _controller,
                style: TextStyle(fontSize: 16, height: 1.5),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.info_search,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(themeVars.radius),
                      bottomLeft: Radius.circular(themeVars.radius),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(themeVars.radius),
                      bottomLeft: Radius.circular(themeVars.radius),
                    ),
                    borderSide: BorderSide(width: 2, color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(themeVars.radius),
                      bottomLeft: Radius.circular(themeVars.radius),
                    ),
                    borderSide: BorderSide(width: 2, color: borderColor),
                  ),
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
                                themeVars.placeholderTextColor,
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
          ),
          /* 
           * 搜索按钮
           */
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              onPressed: _handleSearch,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(themeVars.radius),
                    bottomRight: Radius.circular(themeVars.radius),
                  ),
                ),
                backgroundColor: borderColor,
                side: BorderSide.none,
              ),
              child: SvgPicture.asset(
                'assets/icon/search.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
