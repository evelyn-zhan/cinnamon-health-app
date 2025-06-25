import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({
    super.key,
    required this.title,
    required this.author,
    required this.dateCreated,
    required this.imageUrl,
    required this.detail
  });

  final String title, author, dateCreated, imageUrl;
  final List detail;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  List<String> comments = ['Wow!! Such a good insight!', 'Nice'];

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: Color(0xFF1E1E1E),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, maxLines: 2, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person_rounded, color: Colors.white, size: 20),
                              SizedBox(width: 5),
                              Text(widget.author, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))
                            ]
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month_rounded, color: Colors.white, size: 20),
                              SizedBox(width: 5),
                              Text(widget.dateCreated, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))
                            ]
                          )
                        ]
                      ),
                      SizedBox(height: 25),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(widget.imageUrl, width: double.infinity, height: 160, fit: BoxFit.cover),
                      )
                    ]
                  )
                ]
              )
            ),
            ...widget.detail.map((paragraph) {
              return
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Text(paragraph, textAlign: TextAlign.justify, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400))
              );
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Comments', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.message_outlined, color: Theme.of(context).iconTheme.color, size: 20),
                              label: Text('Type your comment here...', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                              floatingLabelStyle: GoogleFonts.poppins(color: Theme.of(context).iconTheme.color, fontSize: 14, fontWeight: FontWeight.w400),
                              enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                              focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                              contentPadding: EdgeInsets.symmetric(vertical: 5)
                            ),
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)
                          )
                        )
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (commentController.text.isNotEmpty) {
                              comments.add(commentController.text);
                            }
                            commentController.clear();
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Color(0xFF1E1E1E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        icon: Icon(Icons.send_rounded, color: Colors.white, size: 21)
                      )
                    ]
                  ),
                  ...comments.map((comment) {
                    return
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD9D9D9),
                            width: 1.5
                          )
                        )
                      ),
                      child: Text(comment, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400))
                    );
                  })
                ]
              )
            )
          ]
        )
      )
    );
  }
}