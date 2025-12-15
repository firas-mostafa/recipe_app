import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, WatchContext;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/presentation/new_recipe/logic/image_picker/image_picker_cubit.dart'
    show ImagePickerCubit;
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;

class RecipePicturePicker extends StatelessWidget {
  const RecipePicturePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePickerCubit = context.read<ImagePickerCubit>();
    return Center(
      child: context.watch<ImagePickerCubit>().state.image == null
          ? GestureDetector(
              onTap: () {
                imagePickerCubit.setImage();
              },
              child: Container(
                margin: EdgeInsets.only(top: context.setHeight(10)),
                width: context.setWidth(500),
                height: context.setHeight(200),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadiusGeometry.circular(15),
                  border: Border.all(
                    width: context.setMineSize(2),
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.setHeight(130),
                      width: context.setHeight(500),

                      child: SvgIcon(
                        ImageHelper.plus,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    Text(
                      "add image",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                SizedBox(
                  width: context.setWidth(500),
                  height: context.setHeight(200),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      context.setMineSize(15),
                    ),

                    child: Image.file(
                      fit: BoxFit.cover,
                      File(context.watch<ImagePickerCubit>().state.image!.path),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: context.setMineSize(2),
                    left: context.setMineSize(2),
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainer.withAlpha(230),
                    borderRadius: BorderRadius.circular(
                      context.setMineSize(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          imagePickerCubit.setImage();
                        },
                        icon: SvgIcon(
                          ImageHelper.upload,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: context.setHeight(10)),
                      IconButton(
                        onPressed: () {
                          imagePickerCubit.clear();
                        },
                        icon: SvgIcon(
                          ImageHelper.trash,
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
