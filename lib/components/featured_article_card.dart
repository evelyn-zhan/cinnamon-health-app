import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedArticleCard extends StatelessWidget {
  const FeaturedArticleCard({super.key, required this.imageUrl, required this.title, required this.summary});

  final String imageUrl, title, summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170, height: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 1, blurRadius: 5, offset: Offset(0, 5))
        ]
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imageUrl, width: 150, height: 80, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(title, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(summary, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400)),
          )
        ]
      )
    );
  }
}