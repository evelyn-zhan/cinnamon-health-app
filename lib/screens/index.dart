import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/components/add_task_button.dart';
import 'package:health_mobile_app/components/profile_drawer.dart';
import 'package:health_mobile_app/providers/page_provider.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.watch<PageProvider>().pageName == ""
        ? null
        : AppBar(
            backgroundColor: Color(0xFF1E1E1E),
            leading: IconButton(
              onPressed: () {
                if (context.read<PageProvider>().pageIndex == 2) {
                  context.read<TodoProvider>().changeActive("todo");
                }
                context.read<PageProvider>().changePage(0);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20)
            ),
            actions: context.read<PageProvider>().pageIndex == 2
              ? [
                  PopupMenuButton(
                    color: Colors.white,
                    icon: Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
                    itemBuilder: (context) {
                      return <PopupMenuEntry>[
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.check_box_outlined, color: Color(0xFF0369A1), size: 20),
                            title: Text(
                              "Mark all as finished",
                              style: GoogleFonts.poppins(color: Color(0xFF0369A1), fontSize: 15, fontWeight: FontWeight.w600)
                            ),
                            onTap: () {
                              context.read<TodoProvider>().markAllAsFinished();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showMaterialBanner(
                                MaterialBanner(
                                  backgroundColor: Colors.white,
                                  leading: Icon(Icons.celebration_rounded,
                                  color: Color(0xFF0369A1), size: 20),
                                  content: Text(
                                    "All tasks have been marked as finished!",
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                                      child: Text(
                                        "CLOSE",
                                        style: GoogleFonts.poppins(color: Color(0xFF0369A1), fontSize: 13, fontWeight: FontWeight.w600)
                                      )
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ];
                    },
                  )
                ]
              : null,
            title: Text(
              context.watch<PageProvider>().pageName,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)
            ),
            centerTitle: true
          ),
      body: SafeArea(
        child: context.read<PageProvider>().page[context.watch<PageProvider>().pageIndex],
      ),
      floatingActionButton: context.watch<PageProvider>().pageIndex == 2
        ? Builder(builder: (context) => AddTaskButton())
        : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        backgroundColor: Color(0xFF1E1E1E),
        unselectedItemColor: Color(0xFFC8C8C8),
        selectedItemColor: Colors.white,
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        currentIndex: context.watch<PageProvider>().pageIndex,
        onTap: (int index) => context.read<PageProvider>().changePage(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article_rounded), label: "Articles"),
          BottomNavigationBarItem(icon: Icon(Icons.task_outlined), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Recipes"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Progress"),
        ]
      ),
      drawer: ProfileDrawer(),
    );
  }
}