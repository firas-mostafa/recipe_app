import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/presentation/new_recipe/screens/new_recipe.dart'
    show AddNewRecipe;
import 'package:recipe_app/presentation/profile/screens/profile.dart'
    show Profile;
import 'package:recipe_app/presentation/main/logic/index_cubit/index_cubit.dart'
    show IndexCubit;
import 'package:recipe_app/presentation/home/screens/home.dart' show Home;
import 'package:recipe_app/presentation/main/widgets/bottom_nav_bar.dart'
    show BottomNavBar;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      ImageHelper.home,
      ImageHelper.feather,
      ImageHelper.user,
    ];
    List<String> titles = ["Home", "New Recipe", "Profile"];
    List<Widget> screens = [Home(), AddNewRecipe(), Profile()];
    return BlocProvider(
      create: (context) => IndexCubit(),
      child: Scaffold(
        body: Builder(
          builder: (indexContext) {
            return screens[indexContext.watch<IndexCubit>().state.indexValue];
          },
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: BottomNavBar(icons, titles),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
