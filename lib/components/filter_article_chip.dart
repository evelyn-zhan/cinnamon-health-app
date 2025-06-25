import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class FilterArticleChip extends StatelessWidget {
  FilterArticleChip({
    super.key,
    required this.category,
    required this.onSelectedHandler
  });

  Map<String, dynamic> category;
  Function onSelectedHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: FilterChip(
        label: Text(category["category"], style: GoogleFonts.poppins(color: category["selected"] || context.watch<ProfileProvider>().isDark ? Colors.white : Colors.black, fontSize: 13, fontWeight: FontWeight.w600)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFF0369A1), width: 1.5)
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedColor: Color(0xFF0369A1),
        showCheckmark: false,
        selected: category["selected"],
        onSelected: (value) => onSelectedHandler(category, value)
      )
    );
  }
}