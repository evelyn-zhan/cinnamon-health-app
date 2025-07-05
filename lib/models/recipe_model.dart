import 'package:health_mobile_app/models/ingredient_model.dart';

class RecipeModel {

  RecipeModel({
    required this.recipeName,
    required this.imageLink,
    required this.category,
    required this.servings,
    required this.prepTime,
    required this.ingredients,
    required this.instructions,
    required this.calories
  });

  String recipeName, imageLink, category, prepTime;
  int servings, calories;

  List <IngredientModel> ingredients;
  List <String> instructions;

}
