import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_mobile_app/models/ingredient_model.dart';
import 'package:health_mobile_app/models/recipe_model.dart';

class RecipeProvider with ChangeNotifier{
  List <RecipeModel> recipes = [];

  void getRecipes() async {
    final String response = await rootBundle.loadString('assets/json/recipes.json');
    final data = await jsonDecode(response);
    recipes = [
      ...data.map((e) {
        return RecipeModel(
          recipeName: e["recipeName"],
          imageLink: e["imageLink"],
          category: e["category"],
          servings: e["servings"],
          prepTime: e["prepTime"],
          ingredients: [
            ...e["ingredients"].map((e) => IngredientModel(
              name: e["name"],
              quantity: e["quantity"],
              unit: e["unit"],
            ))
          ],
          instructions: [
            ...e["instructions"]
          ],
          calories: e["calories"],
        );
      })
    ];

    notifyListeners();
  }

}