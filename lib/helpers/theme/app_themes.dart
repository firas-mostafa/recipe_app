import "package:flutter/material.dart"
    show Color, ColorScheme, Brightness, TextTheme, ThemeData;

class AppThemes {
  final TextTheme textTheme;

  const AppThemes(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a65),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df2ea),
      onPrimaryContainer: Color(0xff00504c),
      secondary: Color(0xff4a6361),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e4),
      onSecondaryContainer: Color(0xff324b49),
      tertiary: Color(0xff48607b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcfe4ff),
      onTertiaryContainer: Color(0xff304962),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3f4947),
      outline: Color(0xff6f7978),
      outlineVariant: Color(0xffbec9c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5ce),
      primaryFixed: Color(0xff9df2ea),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5ce),
      onPrimaryFixedVariant: Color(0xff00504c),
      secondaryFixed: Color(0xffcce8e4),
      onSecondaryFixed: Color(0xff051f1e),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xffcfe4ff),
      onTertiaryFixed: Color(0xff001d34),
      tertiaryFixedDim: Color(0xffb0c9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff81d5ce),
      surfaceTint: Color(0xff81d5ce),
      onPrimary: Color(0xff003734),
      primaryContainer: Color(0xff00504c),
      onPrimaryContainer: Color(0xff9df2ea),
      secondary: Color(0xffb0ccc9),
      onSecondary: Color(0xff1c3533),
      secondaryContainer: Color(0xff324b49),
      onSecondaryContainer: Color(0xffcce8e4),
      tertiary: Color(0xffb0c9e7),
      onTertiary: Color(0xff18324a),
      tertiaryContainer: Color(0xff304962),
      onTertiaryContainer: Color(0xffcfe4ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e2),
      onSurfaceVariant: Color(0xffbec9c7),
      outline: Color(0xff889391),
      outlineVariant: Color(0xff3f4947),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff006a65),
      primaryFixed: Color(0xff9df2ea),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5ce),
      onPrimaryFixedVariant: Color(0xff00504c),
      secondaryFixed: Color(0xffcce8e4),
      onSecondaryFixed: Color(0xff051f1e),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xffcfe4ff),
      onTertiaryFixed: Color(0xff001d34),
      tertiaryFixedDim: Color(0xffb0c9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff2f3635),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
