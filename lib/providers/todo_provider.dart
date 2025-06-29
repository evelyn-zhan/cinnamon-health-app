import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<Map<String, dynamic>> todoList = [];
  String active = "todo";
  int todoCount = 0, finishedCount = 0;

  Map<String, dynamic>? lastRemovedTask;
  int? lastRemovedTaskIndex;

  void changeActive(String page) {
    active = page;
    notifyListeners();
  }

  void addTask(String title, String? category) {
    Color categoryColor;

    if (category == "Fitness") {
      categoryColor = Color(0xFF0369A1);
    } else if (category == "Nutrition") {
      categoryColor = Color(0xFF16A34A);
    } else if (category == "Self Care") {
      categoryColor = Color(0xFFCA8A04);
    } else {
      categoryColor = Color(0xFF555555);
    }

    todoList.add({
      "title": title,
      "category": category,
      "color": categoryColor,
      "done": false
    });

    recalculateCounts();
    notifyListeners();
  }

  void checkTask(Map<String, dynamic> task) {
    task["done"] = !task["done"];
    recalculateCounts();
    notifyListeners();
  }

  void removeTask(Map<String, dynamic> task) {
    lastRemovedTaskIndex = todoList.indexOf(task);
    lastRemovedTask = task;
    todoList.remove(task);
    recalculateCounts();
    notifyListeners();
  }

  void undoRemove() {
    if (lastRemovedTask != null && lastRemovedTaskIndex != null) {
      todoList.insert(lastRemovedTaskIndex!, lastRemovedTask!);
      recalculateCounts();
      notifyListeners();
    }
  }

  void recalculateCounts() {
    todoCount = todoList.where((task) => !task["done"]).length;
    finishedCount = todoList.where((task) => task["done"]).length;
  }

  void markAllAsFinished() {
    todoList.forEach((task) => task["done"] = true);
    recalculateCounts();
    notifyListeners();
  }
}