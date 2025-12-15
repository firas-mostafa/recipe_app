import 'package:flutter/material.dart';
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;

class CustomTextButton extends StatelessWidget {
  VoidCallback onTap;

  String text;

  CustomTextButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
