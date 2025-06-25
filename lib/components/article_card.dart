import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:health_mobile_app/screens/article_detail.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.dateCreated,
    required this.detail
  });

  final String title, author, imageUrl, description, dateCreated;
  final List detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetail(title: title, author: author, dateCreated: dateCreated, imageUrl: imageUrl, detail: detail)));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 1, blurRadius: 5, offset: Offset(0, 5))
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(imageUrl, width: 130, height: 120, fit: BoxFit.cover),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, maxLines: 2, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                      SizedBox(height: 3),
                      Text(description, maxLines: 3, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400))
                    ]
                  ),
                  Text(dateCreated, style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 12, fontWeight: FontWeight.w600))
                ]
              ),
            )
          ]
        )
      ),
    );
  }
}