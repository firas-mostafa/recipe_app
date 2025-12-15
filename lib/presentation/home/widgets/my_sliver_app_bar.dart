import 'package:flutter/material.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;

class MySliverAppBar extends StatelessWidget {
  final Widget child;

  const MySliverAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.setHeight(240),
      backgroundColor: context.colorScheme.surface,
      collapsedHeight: context.setHeight(87),
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(top: context.setHeight(40)),
          child: Text(
            'Embark on your cooking journey',
            style: context.textTheme.headlineLarge!.copyWith(
              color: context.colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        title: SizedBox(
          height: context.setHeight(87),
          child: Center(child: child),
        ),
        centerTitle: true,
        expandedTitleScale: 1,
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
    );
  }
}
