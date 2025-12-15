import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocConsumer, BlocProvider, ReadContext;

import 'package:recipe_app/presentation/new_recipe/widgets/custom_tile_title.dart'
    show CustomTileTitle;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/device_utils.dart'
    show DeviceUtils;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/logic/recipe_cubit/recipe_cubit.dart';
import 'package:recipe_app/presentation/new_recipe/logic/image_picker/image_picker_cubit.dart'
    show ImagePickerCubit;
import 'package:recipe_app/presentation/new_recipe/widgets/ingredients_tags_build.dart'
    show IngredientsTagsList;

import 'package:recipe_app/presentation/new_recipe/widgets/recipe_picture.dart'
    show RecipePicturePicker;
import 'package:recipe_app/presentation/widgets/custom_button.dart'
    show CustomButton;
import 'package:recipe_app/presentation/widgets/custom_dialog.dart'
    show CustomDialog;
import 'package:recipe_app/presentation/widgets/custom_text_field.dart'
    show CustomTextField;

class AddNewRecipe extends StatelessWidget {
  const AddNewRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    ImagePickerCubit imagePickerCubit = ImagePickerCubit();
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (consumerContext, state) {
        if (state is CreateRecipeSuccess) {
          // context.read<IndexCubit>().changeIndex(0);
          showDialog(
            context: consumerContext,
            builder: (context) => CustomDialog(
              icon: ImageHelper.smile,
              backgroundColor: context.colorScheme.primaryContainer,
              text: "Create Recipe Success",
              textColor: context.colorScheme.onPrimaryContainer,
            ),
          );
        } else if (state is CreateRecipeFailure) {
          showDialog(
            context: consumerContext,
            builder: (context) => CustomDialog(
              icon: ImageHelper.frown,
              backgroundColor: context.colorScheme.errorContainer,
              text: state.errorMessage,
              textColor: context.colorScheme.onErrorContainer,
            ),
          );
        }
      },
      builder: (consumerContext, state) {
        RecipeCubit cubit = consumerContext.read<RecipeCubit>();

        return SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsetsGeometry.all(context.setMineSize(10)),
              child: SizedBox(
                width: DeviceUtils.valueDecider(
                  context,
                  onMobile: context.setWidth(500),
                  onDesktop: context.setWidth(300),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocProvider(
                        create: (context) => imagePickerCubit,
                        child: RecipePicturePicker(),
                      ),
                      CustomTileTitle("Recipe title *"),
                      CustomTextField(
                        controller: cubit.recipeCreateTitle,
                        text: "title",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            consumerContext,
                          ).requestFocus(cubit.recipeCreateTimeMinutesNode);
                        },
                        focusNode: cubit.recipeCreateTitleNode,
                      ),
                      CustomTileTitle("Recipe time *"),
                      CustomTextField(
                        controller: cubit.recipeCreateTimeMinutes,
                        text: "time (minutes)",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            consumerContext,
                          ).requestFocus(cubit.recipeCreatepriceNode);
                        },
                        focusNode: cubit.recipeCreateTimeMinutesNode,
                      ),
                      CustomTileTitle("Recipe expected cost *"),
                      CustomTextField(
                        controller: cubit.recipeCreateprice,
                        text: "expected cost",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            consumerContext,
                          ).requestFocus(cubit.recipeCreatelinkNode);
                        },
                        focusNode: cubit.recipeCreatepriceNode,
                      ),
                      CustomTileTitle("Add a reference"),
                      CustomTextField(
                        controller: cubit.recipeCreatelink,
                        text: "link",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            consumerContext,
                          ).requestFocus(cubit.recipeCreateIngredientNode);
                        },
                        focusNode: cubit.recipeCreatelinkNode,
                      ),
                      CustomTileTitle("Recipe ingredients"),
                      IngredientsTagsList(
                        cubit: cubit,
                        tags: state is TagsAndIngredients
                            ? state.ingredients
                            : [],
                        removeList: cubit.ingredients,
                      ),
                      CustomTextField(
                        controller: cubit.recipeCreateIngredient,
                        text: 'Add Ingredient',
                        textInputAction: TextInputAction.none,
                        onFieldSubmitted: (_) {
                          cubit.addIngredient();
                        },
                        focusNode: cubit.recipeCreateIngredientNode,
                      ),
                      CustomTileTitle("Recipe Tags"),
                      IngredientsTagsList(
                        cubit: cubit,
                        tags: state is TagsAndIngredients ? state.tags : [],
                        removeList: cubit.tags,
                      ),
                      CustomTextField(
                        controller: cubit.recipeCreateTag,
                        text: 'Add tag',
                        textInputAction: TextInputAction.none,
                        onFieldSubmitted: (_) {
                          cubit.addTag();
                        },
                        focusNode: cubit.recipeCreateTagNode,
                      ),
                      CustomTileTitle("Recipe description"),
                      BlocProvider.value(
                        value: imagePickerCubit,
                        child: Builder(
                          builder: (buildContext) {
                            return CustomTextField(
                              controller: cubit.recipeCreatedescription,
                              text: "description",
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                cubit.recipeCreate(
                                  image: buildContext
                                      .read<ImagePickerCubit>()
                                      .state
                                      .image,
                                );
                                cubit.getRecipesList();
                              },
                              focusNode: cubit.recipeCreatedescriptionNode,
                              minLines: 6,
                              maxLines: 7,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: context.setHeight(40)),
                      BlocProvider.value(
                        value: imagePickerCubit,
                        child: Builder(
                          builder: (buildContext) {
                            return state is CreateRecipeLoading
                                ? Center(child: CircularProgressIndicator())
                                : CustomButton(
                                    onTap: () {
                                      cubit.recipeCreate(
                                        image: buildContext
                                            .read<ImagePickerCubit>()
                                            .state
                                            .image,
                                      );
                                      cubit.getRecipesList();
                                    },
                                    text: "Submit",
                                  );
                          },
                        ),
                      ),
                      SizedBox(height: context.setHeight(100)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
