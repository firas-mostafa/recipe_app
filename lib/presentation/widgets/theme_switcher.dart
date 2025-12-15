import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show WatchContext, ReadContext;

import 'package:recipe_app/helpers/theme/logic/theme_cubit.dart'
    show ThemeCubit;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/device_utils.dart'
    show DeviceUtils;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;

class ThemeSwitcher extends StatelessWidget {
  final Color? color;
  const ThemeSwitcher({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    Widget iconSelector() {
      switch (context.watch<ThemeCubit>().state.themeMode) {
        case ThemeMode.light:
          return SvgIcon(
            ImageHelper.sun,
            color: color ?? context.colorScheme.tertiary,
          );
        case ThemeMode.dark:
          return SvgIcon(
            ImageHelper.moon,
            color: color ?? context.colorScheme.tertiary,
          );
        case ThemeMode.system:
          if ((Platform.isAndroid || Platform.isIOS) &&
              DeviceUtils.isMobile(context)) {
            return SvgIcon(
              ImageHelper.smartphone,
              color: color ?? context.colorScheme.tertiary,
            );
          } else if ((Platform.isAndroid || Platform.isIOS) &&
              DeviceUtils.isTablet(context)) {
            return SvgIcon(
              ImageHelper.tablet,
              color: color ?? context.colorScheme.tertiary,
            );
          } else {
            return SvgIcon(
              ImageHelper.pc,
              color: color ?? context.colorScheme.tertiary,
            );
          }
      }
    }

    void onTap() {
      switch (context.read<ThemeCubit>().state.themeMode) {
        case ThemeMode.light:
          context.read<ThemeCubit>().setDark();
        case ThemeMode.dark:
          context.read<ThemeCubit>().setSystem();
        case ThemeMode.system:
          context.read<ThemeCubit>().setLight();
      }
    }

    return IconButton(
      icon: iconSelector(),
      onPressed: () {
        onTap();
      },
    );
  }
}
