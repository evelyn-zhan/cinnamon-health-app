import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String comparisonText;
  final String imageAsset;
  final List<Color> gradientColors;
  final Alignment beginGradient;
  final Alignment endGradient;

  const InfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.comparisonText,
    required this.imageAsset,
    required this.gradientColors,
    this.beginGradient = Alignment.topLeft,
    this.endGradient = Alignment.bottomRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: beginGradient,
          end: endGradient,
        ),
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
         BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 1, blurRadius: 3, offset: Offset(0, 5))
       ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text(value, style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text(comparisonText, style: GoogleFonts.poppins(fontSize: 13))
              ]
            )
          ),
          SizedBox(width: 10),
          Image.asset(
            imageAsset,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
