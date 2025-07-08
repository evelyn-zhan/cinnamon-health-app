import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/models/recipe_model.dart';

class RecipeDetail extends StatelessWidget {
  RecipeDetail({super.key, required this.recipe});

  RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20)
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30), 
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(recipe.imageLink, width: double.infinity, height: 220, fit: BoxFit.cover),
            ),
            SizedBox(height: 15),
            Text(recipe.recipeName, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),),
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, size: 20, color: Colors.grey,),
                    SizedBox(width: 10),
                    Text(recipe.prepTime, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),)
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, size: 20, color: Colors.grey,),
                    SizedBox(width: 10),
                    Text("${recipe.servings} servings", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),)
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.local_fire_department_rounded, size: 20, color: Colors.grey,),
                    SizedBox(width: 10),
                    Text("${recipe.calories} calories", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),)
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text("Ingredients", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),),
            SizedBox(height: 5,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recipe.ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  leading: Icon(Icons.circle, size: 8,),
                  title: Text("${recipe.ingredients[index].name} ― ${recipe.ingredients[index].quantity} ${recipe.ingredients[index].unit}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                );
              },
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text("Instructions", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),),
            SizedBox(height: 5,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recipe.instructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  leading: Text("${index + 1}. ", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                  title: Text("${recipe.instructions[index]}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                );
              },
            ),
          ],
        )
      ),
    );
  }
}