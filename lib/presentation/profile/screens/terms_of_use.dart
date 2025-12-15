import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: context.setMineSize(60),

        leading: IconButton(
          iconSize: context.setMineSize(200),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageHelper.chevronLeft,
            colorFilter: ColorFilter.mode(
              context.colorScheme.onSurface,
              BlendMode.srcIn,
            ),
            width: context.setMineSize(200),
            height: context.setMineSize(200),
          ),
        ),
        title: Text(
          "Term of use",
          style: context.textTheme.headlineMedium!.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: context.setMineSize(600),
          child: Padding(
            padding: EdgeInsetsGeometry.all(context.setMineSize(20)),
            child: Text(
              '''Lorem ipsum dolor sit amet Stet amet exerci tation lorem lobortis nonumy esse tempor et volutpat minim. Et sed volutpat amet diam takimata lobortis sed ex et duo sed nostrud sit. Amet at sanctus esse lorem amet sit aliquyam accusam zzril sit accusam consetetur dolore lorem invidunt dolore.
                
                Amet diam lorem nibh gubergren sit ut dolore vel veniam. Et lobortis sed clita in sadipscing enim ut amet. Amet consetetur duis justo. Justo quis sit iriure erat luptatum laoreet lorem dolor duo sed lorem lobortis nonumy delenit duo justo eleifend. Ipsum ea magna et nam eum lorem dolores sea ullamcorper enim et sadipscing consetetur takimata nonummy sanctus. Tempor adipiscing sadipscing sea sit nonumy nihil ipsum tempor gubergren dolor ut feugiat dolore sanctus sit. Iriure magna adipiscing. Lorem kasd dolore rebum stet wisi amet lorem accumsan aliquip nulla no.
                
                Et dolor iriure rebum sed cum lorem ipsum diam accusam velit consetetur eirmod lorem nibh sed sit. In sed tempor ut nonumy. Tempor diam magna est sit nibh molestie amet.''',
            ),
          ),
        ),
      ),
    );
  }
}
