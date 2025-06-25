import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/components/todo_card.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class ToDoList extends StatelessWidget {
  ToDoList({
    super.key,
    required this.isFinished
  });

  bool isFinished;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !isFinished ? "My To Do List" : "My Finished Tasks",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)
                ),
                Text(
                  !isFinished ? "Stay healthy and productive all the time" : "Keep going, you're doing great!",
                  style: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 15, fontWeight: FontWeight.w600)
                ),
              ]
            ),
            SizedBox(height: 16),
            Divider(color: Color(0xFFC8C8C8), height: 2, thickness: 1.5),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  if (!isFinished)
                    ...context.watch<TodoProvider>().todoList
                    .where((task) => !task["done"])
                    .map((task) => ToDoCard(task: task))
                  else
                    ...context.watch<TodoProvider>().todoList
                    .where((task) => task["done"])
                    .map((task) => ToDoCard(task: task))
                ]
              )
            )
          ]
        )
      )
    );
  }
}