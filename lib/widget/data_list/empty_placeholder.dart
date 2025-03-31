import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/theme/global.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 48),
        SvgPicture.asset(
          'assets/icon/empty.svg',
          width: 64,
          height: 64,
          colorFilter: ColorFilter.mode(
            themeVars.placeholderTextColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.info_data_empty,
          style: TextStyle(
            color: themeVars.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
