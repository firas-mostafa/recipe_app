import 'package:flutter/material.dart';
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;

class CustomProfileTile extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback? onSufixTap;
  final String? sufix;
  const CustomProfileTile({
    super.key,
    required this.icon,
    required this.text,
    this.sufix,
    this.onSufixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: ListTile(
            leading: SvgIcon(icon),
            title: Text(
              text,
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorScheme.tertiary,
              ),
            ),
          ),
        ),
        sufix != null
            ? IconButton(onPressed: onSufixTap ?? () {}, icon: SvgIcon(sufix!))
            : SizedBox(),
      ],
    );
  }
}
