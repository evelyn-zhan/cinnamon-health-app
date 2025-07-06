import 'package:flutter/material.dart';
import 'package:health_mobile_app/components/recipe_card.dart';
import 'package:health_mobile_app/models/recipe_model.dart';
import 'package:health_mobile_app/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  @override
  void initState() {
    super.initState();
    context.read<RecipeProvider>().getRecipes();
  }


  @override
  Widget build(BuildContext context) {
    List <RecipeModel> recipes = context.watch<RecipeProvider>().recipes;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9
        ), 
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: recipes[index],
          );
        }),
    );
  }
}