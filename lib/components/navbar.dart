import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/screens/home.dart';
import 'package:health_mobile_app/screens/articles.dart';
import 'package:health_mobile_app/screens/todo.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key, required this.page});

  final String page;
  List<Map<String, dynamic>> NavList = [
    {
      "widget": Home(),
      "icon": Icons.home_rounded,
      "text": "Home",
    },
    {
      "widget": Articles(),
      "icon": Icons.article_rounded,
      "text": "Articles",
    },
    {
      "widget": ToDo(),
      "icon": Icons.task_outlined,
      "text": "Tasks",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...NavList.map((nav) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => nav["widget"]));
              },
              child: Column(
                children: [
                  Icon(nav["icon"], color: page == nav["text"] ? Colors.white : Color(0xFFC8C8C8), size: 30),
                  SizedBox(height: 3),
                  Text(nav["text"], style: GoogleFonts.poppins(color: page == nav["text"] ? Colors.white : Color(0xFFC8C8C8), fontSize: 13, fontWeight: FontWeight.w600))
                ]
              ),
            );
          })
        ]
      )
    );
  }
}