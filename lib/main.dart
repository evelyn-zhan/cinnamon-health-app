import 'package:flutter/material.dart';
import 'package:health_mobile_app/providers/login_signup_provider.dart';
import 'package:health_mobile_app/providers/page_provider.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';
import 'package:health_mobile_app/providers/recipe_provider.dart';
import 'package:health_mobile_app/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';
import 'package:health_mobile_app/providers/progress_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => ProgressProvider()),
        ChangeNotifierProvider(create: (context) => LoginSignupProvider()),
      ],
      child: MyApp(),
    ),
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
              borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5)
              )
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white, foregroundColor: Colors.black),
              drawerTheme: DrawerThemeData(backgroundColor: Color(0xFF1E1E1E)),
              listTileTheme: ListTileThemeData(tileColor: Color(0xFF1E1E1E)),
              bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFF1E1E1E)),
              iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: Colors.white)),
              checkboxTheme: CheckboxThemeData(checkColor: MaterialStateProperty.all(Colors.white)
            ),
            cardTheme: CardTheme(color: Color(0xFF1E1E1E))
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
            drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
            listTileTheme: ListTileThemeData(tileColor: Colors.white),
            bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
            iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: Colors.black)),
            tabBarTheme: TabBarTheme(unselectedLabelColor: Color(0xFF1E1E1E)),
            checkboxTheme: CheckboxThemeData(checkColor: MaterialStateProperty.all(Colors.white)),
            cardTheme: CardTheme(color: Colors.white)
          ),
      home: Login()
    );
  }
}
