import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/components/add_task_button.dart';
import 'package:health_mobile_app/components/profile_drawer.dart';
import 'package:health_mobile_app/providers/page_provider.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoProvider()
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider()
        )
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ProfileProvider>().isDark
      ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Color(0xFF1E1E1E),
        shadowColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5)
          )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xFF1E1E1E)
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Color(0xFF1E1E1E)
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color(0xFF1E1E1E)
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white
          )
        )
      )
      : ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
        canvasColor: Colors.white,
        shadowColor: Color(0xFFD9D9D9),
        iconTheme: IconThemeData(color: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E1E1E), width: 1),
            borderRadius: BorderRadius.circular(5)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E1E1E), width: 1),
            borderRadius: BorderRadius.circular(5)
          )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.white
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.black
          )
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Color(0xFF1E1E1E),
        )
      ),
      home: Scaffold(
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
            title: Text(context.watch<PageProvider>().pageName, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
            centerTitle: true
          ),
        body: SafeArea(
          child: context.read<PageProvider>().page[context.watch<PageProvider>().pageIndex],
        ),
        floatingActionButton:
        context.watch<PageProvider>().pageIndex == 2
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
          ]
        ),
        drawer: ProfileDrawer()
      )
    );
  }
}