import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseCard extends StatelessWidget {
  final String? iconAsset;
  final String title;
  final String value;
  final String valueSuffix;
  final Color valueColor;

  const ExerciseCard({
    Key? key,
    required this.iconAsset,
    required this.title,
    required this.value,
    required this.valueSuffix,
    required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 1, blurRadius: 3, offset: Offset(0, 5))
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$value ",
                      style: GoogleFonts.poppins(color: valueColor, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                    TextSpan(
                      text: valueSuffix,
                      style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 15, fontWeight: FontWeight.w600)
                    )
                  ]
                )
              )
            ]
          ),
          Spacer(),
          if (iconAsset != null) Image.asset(iconAsset!, width: 30, height: 30),
        ]
      )
    );
  }
}