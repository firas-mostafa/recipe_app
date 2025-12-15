import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'
    show MasonryGridView;
import 'package:recipe_app/helpers/image/image_helper.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;

import 'package:recipe_app/helpers/responsive/device_utils.dart'
    show DeviceUtils;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart';
import 'package:recipe_app/logic/recipe_cubit/recipe_cubit.dart';
import 'package:recipe_app/presentation/home/widgets/recipe_card.dart';
import 'package:recipe_app/presentation/widgets/custom_dialog.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeCubit>().getRecipesList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {
        if (state is GetRecipesFailure) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              icon: ImageHelper.smile,
              backgroundColor: context.colorScheme.errorContainer,
              text: state.errorMessage,
              textColor: context.colorScheme.onErrorContainer,
            ),
          );
        } else if (!(state is GetRecipesLoading ||
            state is GetRecipesSuccess)) {
          context.read<RecipeCubit>().getRecipesList();
        }
      },
      builder: (context, state) {
        return state is GetRecipesLoading
            ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.colorScheme.primary,
                  ),
                ),
              )
            : state is GetRecipesSuccess
            ? Expanded(
                child: MasonryGridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.valueDecider<double>(
                      context,
                      onMobile: context.screenWidth * 0.03,
                      onTablet: context.screenWidth * 0.05,
                      onDesktop: context.screenWidth * 0.1,
                    ),
                    vertical: context.setMineSize(25),
                  ),
                  crossAxisCount: DeviceUtils.valueDecider<int>(
                    context,
                    onMobile: 2,
                    onTablet: 3,
                    onDesktop: 5,
                  ),
                  mainAxisSpacing: context.setMineSize(15),
                  crossAxisSpacing: context.setMineSize(15),
                  itemCount: state.recipes.length,
                  itemBuilder: (context, index) =>
                      RecipeCard(recipeModel: state.recipes[index]),
                ),
              )
            : SizedBox();
      },
    );
  }
}
