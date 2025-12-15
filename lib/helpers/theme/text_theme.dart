import 'package:flutter/material.dart' show TextTheme, BuildContext;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = context.textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,

    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge!.copyWith(
      fontSize: context.setMineSize(30),
    ),
    bodyMedium: bodyTextTheme.bodyMedium!.copyWith(
      fontSize: context.setMineSize(20),
    ),
    bodySmall: bodyTextTheme.bodySmall!.copyWith(
      fontSize: context.setMineSize(14),
    ),
    labelLarge: bodyTextTheme.labelLarge!.copyWith(
      fontSize: context.setMineSize(40),
    ),
    labelMedium: bodyTextTheme.labelMedium!.copyWith(
      fontSize: context.setMineSize(20),
    ),
    labelSmall: bodyTextTheme.labelSmall!.copyWith(
      fontSize: context.setMineSize(14),
    ),
    headlineLarge: displayTextTheme.headlineLarge!.copyWith(
      fontSize: context.setMineSize(50),
    ),
  );
  return textTheme;
}
