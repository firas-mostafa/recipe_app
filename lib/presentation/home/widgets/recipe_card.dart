import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/models/recipe_models/recipe_model.dart';
import 'package:recipe_app/helpers/image/image_helper.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/logic/recipe_cubit/recipe_cubit.dart';
import 'package:recipe_app/presentation/widgets/svg_icon.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipeModel;
  const RecipeCard({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    final hasImage = recipeModel.image != null && recipeModel.image!.isNotEmpty;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(context.setMineSize(25)),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withAlpha(80),
                blurRadius: 30,
                offset: const Offset(3, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hasImage
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        context.setMineSize(25),
                      ),
                      child: IntrinsicHeight(
                        child: Image.network(
                          cacheWidth: 400,

                          recipeModel.image!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(height: context.setMineSize(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.setMineSize(20.0),
                  vertical: context.setMineSize(10),
                ),
                child: Text(
                  recipeModel.title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: context.colorScheme.tertiary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.setMineSize(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${recipeModel.price}\$",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "${recipeModel.timeMinutes} M",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: context.setMineSize(90),
            height: context.setMineSize(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(context.setMineSize(15)),
                topRight: Radius.circular(context.setMineSize(25)),
              ),
              gradient: LinearGradient(
                colors: [
                  context.colorScheme.errorContainer.withAlpha(150),
                  context.colorScheme.primaryContainer.withAlpha(150),
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: context.setMineSize(17),
                    child: GestureDetector(
                      onTap: () {
                        context.read<RecipeCubit>().deleteRecipeByID(
                          recipeModel.id,
                        );
                      },
                      child: SvgIcon(
                        ImageHelper.trash,
                        color: context.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: context.setMineSize(17),
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgIcon(
                        ImageHelper.edit,
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
