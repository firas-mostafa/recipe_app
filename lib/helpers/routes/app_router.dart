import 'package:flutter/material.dart'
    show RouteSettings, Route, MaterialPageRoute;
import 'package:recipe_app/presentation/profile/screens/edit_profile.dart'
    show EditProfile;
import 'package:recipe_app/presentation/profile/screens/terms_of_use.dart'
    show TermsOfUse;
import 'package:recipe_app/presentation/auth/screens/create_account.dart'
    show CreateAccount;
import 'package:recipe_app/presentation/auth/screens/login.dart' show Login;
import 'package:recipe_app/presentation/main/screens/main_screen.dart'
    show MainScreen;
// Import your recipe detail screen
import 'package:recipe_app/presentation/recipe/screens/recipe_detail.dart'
    show RecipeDetail;

class AppRouter {
  static const String recipeDetail = 'recipe_detail';
  static String recipeDetailPath(int id) => '$recipeDetail/$id';

  Route onGenerateRoute(RouteSettings routeSettings) {
    final routeName = routeSettings.name ?? '/';

    // Fast path for exact matches first
    switch (routeName) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'create_account':
        return MaterialPageRoute(builder: (_) => CreateAccount());
      case 'terms_of_use':
        return MaterialPageRoute(builder: (_) => TermsOfUse());
      case 'edit_profile':
        return MaterialPageRoute(builder: (_) => EditProfile());
    }

    // Then handle dynamic routes
    if (routeName.startsWith('$recipeDetail/')) {
      final idString = routeName.substring(recipeDetail.length + 1);
      final id = int.tryParse(idString);
      if (id != null) {
        return MaterialPageRoute(
          builder: (_) => RecipeDetail(recipeId: id),
          settings: routeSettings,
        );
      }
    }

    // Fallback
    return MaterialPageRoute(builder: (_) => MainScreen());
  }
}
