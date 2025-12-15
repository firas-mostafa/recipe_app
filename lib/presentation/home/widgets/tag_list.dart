import 'package:flutter/material.dart';
import 'package:recipe_app/helpers/image/image_helper.dart';
import 'package:recipe_app/helpers/responsive/device_utils.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart';
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart';
import 'package:recipe_app/presentation/widgets/svg_icon.dart';

class TagList extends StatelessWidget {
  TagList({super.key});
  List<String> tagsIcon = [
    ImageHelper.grid,
    ImageHelper.friedEgg,
    ImageHelper.rice,
    ImageHelper.salad,
    ImageHelper.sandwich,
    ImageHelper.muffin,
  ];
  List<String> tagNames = [
    "All",
    'Breakfast',
    'Lunch',
    'Dinner',
    'Sandwich',
    'Desert',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setMineSize(90),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.valueDecider<double>(
            context,
            onMobile: context.screenWidth * 0.03,
            onTablet: context.screenWidth * 0.05,
            onDesktop: context.screenWidth * 0.1,
          ),
        ),
        scrollDirection: Axis.horizontal,
        itemCount: tagsIcon.length,
        itemBuilder: (context, index) => Container(
          width: context.setMineSize(90),
          height: context.setMineSize(90),
          margin: EdgeInsets.symmetric(horizontal: context.setMineSize(8)),
          decoration: BoxDecoration(
            color: index == 0
                ? context.colorScheme.primary
                : context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(context.setMineSize(20)),
            // boxShadow: [
            //   BoxShadow(
            //     color: context.colorScheme.shadow.withAlpha(30),
            //     blurRadius: 10,
            //     offset: Offset(2, 5),
            //   ),
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: context.setMineSize(40),
                height: context.setMineSize(40),

                child: SvgIcon(
                  tagsIcon[index],
                  color: index == 0
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.secondary,
                ),
              ),
              Text(
                tagNames[index],
                style: context.textTheme.bodySmall!.copyWith(
                  color: index == 0
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
