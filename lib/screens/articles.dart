import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/components/filter_article_chip.dart';
import 'package:health_mobile_app/components/article_card.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  List articleList = [];

  Future<void> getArticles() async {
    final String response = await rootBundle.loadString('assets/json/articles.json');
    final data = await jsonDecode(response);
    setState(() => articleList = data);
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  List<Map<String, dynamic>> articleCategory = [
    {
      "category": "Lifestyle",
      "selected": false
    },
    {
      "category": "Healthy Food",
      "selected": false
    },
    {
      "category": "Fitness",
      "selected": false
    }
  ];

  List<String> selectedCategory = [];

  void selectCategory(Map<String, dynamic> category, bool value) {
    setState(() {
      category["selected"] = value;
      if (value) {
        selectedCategory.add(category["category"]);
      } else {
        selectedCategory.remove(category["category"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Don't miss the latest articles!", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                        Text('Learn more, gain knowledge', style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 15, fontWeight: FontWeight.w600)),
                      ]
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Filter by tags", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            ...articleCategory.map((category) {
                              return FilterArticleChip(category: category, onSelectedHandler: selectCategory);
                            })
                          ]
                        ),
                        SizedBox(height: 20),
                        ...articleList
                        .where((article) => selectedCategory.contains(article["category"]) || selectedCategory.isEmpty)
                        .map((article) {
                          return ArticleCard(
                            title: article['title'],
                            author: article['author'],
                            dateCreated: article['dateCreated'],
                            imageUrl: article['imageUrl'],
                            description: article['description'],
                            detail: article['detail']
                          );
                        })
                      ]
                    )
                  ]
                ),
              )
            ),
          )
        ]
    );
  }
}