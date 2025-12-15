import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;

class SvgIcon extends StatelessWidget {
  final String url;
  final Color? color;
  const SvgIcon(this.url, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      url,
      colorFilter: ColorFilter.mode(
        color ?? context.colorScheme.tertiary,
        BlendMode.srcIn,
      ),
    );
  }
}
