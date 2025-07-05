// lib/widgets/info_card.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String comparisonText;
  final String imageAsset;
  final List<Color> gradientColors; // Menggunakan List<Color> untuk gradien
  final Alignment beginGradient;
  final Alignment endGradient;
  final Color textColor;
  final Color comparisonTextColor;

  const InfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.comparisonText,
    required this.imageAsset,
    required this.gradientColors,
    this.beginGradient = Alignment.topLeft, // Default top-left
    this.endGradient = Alignment.bottomRight, // Default bottom-right
    required this.textColor,
    required this.comparisonTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: beginGradient,
          end: endGradient,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  comparisonText,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: comparisonTextColor,
                  ),
                ),
              ],
            ),
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
