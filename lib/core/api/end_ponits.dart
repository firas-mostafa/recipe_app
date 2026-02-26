class EndPoint {
  static String baseUrl = "https://n8xsgbkx-8000.euw.devtunnels.ms/";
  // static String baseUrl = "http://localhost:8000/";
  static String api = "api/";
  static String recipe = "${api}recipe/";
  static String user = "${api}user/";
  static String ingredients = "${recipe}ingredients/";
  static String tags = "${recipe}tags/";
  static String uploadUserImage = "${user}user-upload-image/";
  static String me = "${user}me/";
  static String createUser = "${user}create/";
  static String recipes = "${recipe}recipes/";
  static String token = "${user}token/";
  static String recipeByID(int id) => "$recipes$id/";
  static String ingredientsByID(int id) => "$ingredients$id/";
  static String tagsByID(int id) => "$tags$id/";
  static String uploadRecipeImage(int id) => "${recipeByID(id)}upload-image/";
}

class ApiKey {
  static String authorization = "Authorization";
  static String user = "user";
  static String recipe = "recipe";
  static String status = "status";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String nonFieldErrors = "non_field_errors";
  static String message = "message";
  static String id = "id";
  static String name = "name";
  static String confirmPassword = "confirmPassword";
  static String image = "image";
  static String title = "title";
  static String timeMinutes = "time_minutes";
  static String price = "price";
  static String link = "link";
  static String tags = "tags";
  static String ingredients = "ingredients";
  static String description = "description";
  static String detail = "detail";
}
