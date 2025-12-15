import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;

import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/helpers/responsive/device_utils.dart'
    show DeviceUtils;

import 'package:recipe_app/presentation/widgets/theme_switcher.dart'
    show ThemeSwitcher;

class AuthBase extends StatelessWidget {
  final Widget child;
  const AuthBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment(.99, -.99), child: ThemeSwitcher()),
        Center(
          child: Container(
            margin: DeviceUtils.isDesktop(context)
                ? EdgeInsets.symmetric(horizontal: context.setWidth(50))
                : EdgeInsets.zero,
            padding: EdgeInsets.all(context.setMineSize(15)),
            width: context.setWidth(
              DeviceUtils.valueDecider(
                context,
                onMobile: 440,
                onDesktop: 250,
                onTablet: 400,
              ),
            ),
            height: context.setHeight(550),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withAlpha(30),
                  blurRadius: 60,
                  offset: Offset(3, 20),
                ),
              ],
            ),
            child: DeviceUtils.isDesktop(context)
                ? Center(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                            ImageHelper.logoLight,
                            fit: BoxFit.fitHeight,
                            height: context.setMineSize(400),
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: context.setWidth(7)),
                        Expanded(flex: 2, child: child),
                      ],
                    ),
                  )
                : child,
          ),
        ),
      ],
    );
  }
}
