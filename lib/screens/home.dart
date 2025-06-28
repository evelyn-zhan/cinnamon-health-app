import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/page_provider.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:health_mobile_app/components/featured_article_card.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(Icons.menu, size: 30),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Good day, ${context.watch<ProfileProvider>().username} 👋', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                                Text('How are you today?', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF898989)))
                              ]
                            )
                          ]
                        ),
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5)
                          )
                        )
                      ]
                    ),
                    SizedBox(height: 30),
                    Text("Today's Health Summary", style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
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
                                    Text('Steps', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 11),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: '3,200 ', style: GoogleFonts.poppins(color: Color(0xFF16A34A), fontSize: 20, fontWeight: FontWeight.w700)),
                                          TextSpan(text: 'steps', style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 15, fontWeight: FontWeight.w600))
                                        ]
                                      )
                                    )
                                  ]
                                ),
                                Spacer(),
                                Image.asset('assets/images/shoe-icon.png', width: 30, height: 30)
                              ]
                            )
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 100,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 1, blurRadius: 5, offset: Offset(0, 5))
                              ]
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Water', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 11),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: '1.5 ', style: GoogleFonts.poppins(color: Color(0xFF0284C7), fontSize: 20, fontWeight: FontWeight.w700)),
                                          TextSpan(text: 'Litres', style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 15, fontWeight: FontWeight.w600))
                                        ]
                                      )
                                    )
                                  ]
                                ),
                                Spacer(),
                                Image.asset('assets/images/water-icon.png', width: 28, height: 28)
                              ]
                            )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text('Daily Mission', style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity, height: 80,
                      padding: EdgeInsets.all(15),
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
                        Image.asset('assets/images/3d-target.png', width: 45, height: 45),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('5,000 steps in a day', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                              Text('Keep moving, stay healthy!', style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 13, fontWeight: FontWeight.w500))
                            ]
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity, height: 80,
                      padding: EdgeInsets.all(15),
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
                          Image.asset('assets/images/mineral-water.png', width: 45, height: 45),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('2 Litres in a day', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                              Text("Don't forget to stay hydrated!", style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 13, fontWeight: FontWeight.w500))
                            ]
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Featured Articles', style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600)),
                        TextButton(
                          onPressed: () => context.read<PageProvider>().changePage(1),
                          style: TextButton.styleFrom(overlayColor: Colors.transparent),
                          child: Text('See More Articles', style: GoogleFonts.poppins(color: context.watch<ProfileProvider>().isDark? Colors.white : Colors.black, fontSize: 13, fontWeight: FontWeight.w500, decoration: TextDecoration.underline))
                        )
                      ]
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: [
                          FeaturedArticleCard(
                            imageUrl: 'assets/images/article-1.png',
                            title: 'Why Sleep is Your Superpower for Better Health',
                            summary: 'Sleeping 100 hours will make you healthy'
                          ),
                          SizedBox(width: 10),
                          FeaturedArticleCard(
                            imageUrl: 'assets/images/article-3.jpg',
                            title: 'Hydration Hacks: Drink Smarter, Stay Healthier',
                            summary: 'Simple ways to track water intake and avoid dehydration'
                          ),
                          SizedBox(width: 10),
                          FeaturedArticleCard(
                            imageUrl: 'assets/images/article-4.jpg',
                            title: 'Superfoods You Should Eat Every Week',
                            summary: 'Nutrient-packed foods to improve overall well-being'
                          )
                        ]
                      )
                    )
                  ]
                )
              )
          )
        )
      ]
    );
  }
}