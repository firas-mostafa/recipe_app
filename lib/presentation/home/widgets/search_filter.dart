import 'package:flutter/material.dart';
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/presentation/widgets/custom_text_field.dart'
    show CustomTextField;
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SizedBox(
      width: context.setWidth(400),
      height: context.setHeight(45) > 45 ? context.setHeight(45) : 45,
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              onFieldSubmitted: (_) {},
              textInputAction: TextInputAction.done,
              focusNode: FocusNode(),
              controller: controller,
              text: "Search",
              suffix: SizedBox(
                height: context.setMineSize(5),
                width: context.setMineSize(5),
                child: Center(
                  child: SvgIcon(
                    ImageHelper.search,
                    color: context.colorScheme.outline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: context.setMineSize(10)),
          InkWell(
            onTap: () {},
            child: Container(
              width: context.setMineSize(50),
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(context.setMineSize(10)),
              ),
              child: Center(child: SvgIcon(ImageHelper.sliders)),
            ),
          ),
        ],
      ),
    );
  }
}
