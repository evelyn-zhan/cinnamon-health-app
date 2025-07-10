import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/models/recipe_model.dart';
import 'package:health_mobile_app/screens/recipe_detail.dart';

class RecipeCard extends StatelessWidget {
  RecipeCard({super.key, required this.recipe});

  RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipe: recipe))),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Image.asset(recipe.imageLink, fit: BoxFit.cover,),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(recipe.category, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),),
                      ),
                      Row(
                        children: [
                          Icon(Icons.timelapse_rounded, size: 12, color: Colors.grey,),
                          SizedBox(width: 5,),
                          Text(recipe.prepTime, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(recipe.recipeName, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}