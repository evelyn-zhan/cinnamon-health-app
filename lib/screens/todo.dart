import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/components/todo_list.dart';
import 'package:provider/provider.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Color(0xFF0369A1),
            // unselectedLabelColor: Colors.black,
            indicatorColor: Color(0xFF0369A1),
            tabs: [
              Tab(
                child: Text("To Do (${context.watch<TodoProvider>().todoCount})", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600))
              ),
              Tab(
                child: Text("Finished (${context.watch<TodoProvider>().finishedCount})", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600))
              )
            ]
          ),
          Expanded(
            child: TabBarView(
              children: [
                ToDoList(isFinished: false),
                ToDoList(isFinished: true)
              ]
            )
          )
        ]
      ),
    );
  }
}