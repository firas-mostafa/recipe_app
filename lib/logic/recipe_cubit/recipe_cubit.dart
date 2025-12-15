import 'package:flutter/material.dart' show FocusNode, TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:recipe_app/data/models/recipe_models/recipe_image_model.dart';
import 'package:recipe_app/data/models/recipe_models/recipe_model.dart';
import 'package:recipe_app/data/repositories/recipe_repository.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit(this.recipeRepository) : super(RecipeInitial());
  TextEditingController recipeCreateTitle = TextEditingController();
  TextEditingController recipeCreateTimeMinutes = TextEditingController();
  TextEditingController recipeCreateprice = TextEditingController();
  TextEditingController recipeCreatelink = TextEditingController();
  TextEditingController recipeCreatedescription = TextEditingController();
  TextEditingController recipeCreateTag = TextEditingController();
  TextEditingController recipeCreateIngredient = TextEditingController();

  XFile? recipeImage;

  FocusNode recipeCreateTitleNode = FocusNode();
  FocusNode recipeCreateTimeMinutesNode = FocusNode();
  FocusNode recipeCreatepriceNode = FocusNode();
  FocusNode recipeCreatelinkNode = FocusNode();
  FocusNode recipeCreatedescriptionNode = FocusNode();
  FocusNode recipeCreateTagNode = FocusNode();
  FocusNode recipeCreateIngredientNode = FocusNode();

  final RecipeRepository recipeRepository;
  final List<String> tags = [];
  final List<String> ingredients = [];

  void addTag() {
    if (!tags.contains(recipeCreateTag.text) &&
        recipeCreateTag.text.isNotEmpty) {
      tags.add(recipeCreateTag.text);
    }
    recipeCreateTag.clear();
    emit(TagsAndIngredients(tags, ingredients));
  }

  void addIngredient() {
    if (!ingredients.contains(recipeCreateIngredient.text) &&
        recipeCreateIngredient.text.isNotEmpty) {
      ingredients.add(recipeCreateIngredient.text);
    }
    recipeCreateIngredient.clear();
    emit(TagsAndIngredients(tags, ingredients));
  }

  void removeTagsIngredients(int index, List<String> items) {
    items.remove(items[index]);
    emit(TagsAndIngredients(tags, ingredients));
  }

  Future<dynamic> recipeCreate({XFile? image}) async {
    emit(CreateRecipeLoading());
    final response = await recipeRepository.recipeCreate(
      title: recipeCreateTitle.text,
      timeMinutes: int.tryParse(recipeCreateTimeMinutes.text),
      price: recipeCreateprice.text,
      link: recipeCreatelink.text,
      tags: tags,
      ingredients: ingredients,
      description: recipeCreatedescription.text,
    );
    response.fold((errorMessage) => emit(CreateRecipeFailure(errorMessage)), (
      recipe,
    ) {
      if (image != null) {
        uploadRecipeePic(image, recipe.id);
        emit(CreateRecipeSuccess(recipe));
      } else {
        emit(CreateRecipeSuccess(recipe));
      }
    });
  }

  Future<dynamic> uploadRecipeePic(XFile recipeImage, int recipeID) async {
    emit(UploadRecipePicLoading());
    final response = await recipeRepository.uploadRecipeePic(
      recipeID,
      recipeImage,
    );
    response.fold(
      (errorMessage) => emit(UploadRecipePicFailure(errorMessage)),
      (imageModel) => emit(UploadRecipePicSuccess(imageModel)),
    );
  }

  Future<dynamic> getRecipesList() async {
    emit(GetRecipesLoading());
    final response = await recipeRepository.getRecipesList();
    response.fold(
      (errorMessage) => emit(GetRecipesFailure(errorMessage)),
      (recipes) => emit(GetRecipesSuccess(recipes)),
    );
  }

  Future<dynamic> getRecipeByID(int id) async {
    emit(GetRecipeLoading());
    final response = await recipeRepository.getRecipeByID(id);
    response.fold(
      (errorMessage) => emit(GetRecipeFailure(errorMessage)),
      (recipe) => emit(GetRecipeSuccess(recipe)),
    );
  }

  Future<dynamic> deleteRecipeByID(int id) async {
    emit(DeleteRecipeLoading());
    final response = await recipeRepository.deleteRecipeByID(id);
    response.fold(
      (errorMessage) => emit(DeleteRecipeFailure(errorMessage)),
      (_) => emit(DeleteRecipeSuccess()),
    );
  }

  /* ---- methods to be implemented in future ---- */
  // Future<dynamic> patchRecipeByID() {}
  // Future<dynamic> getTagsList() {}
  // Future<dynamic> deleteTagByID() {}
  // Future<dynamic> deleteIngredientsByID() {}
  // Future<dynamic> patchIngredientByID() {}
  // Future<dynamic> patchTagByID() {}
}
