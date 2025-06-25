import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<Map<String, dynamic>> todoList = [];
  String active = "todo";
  int todoCount = 0, finishedCount = 0;

  Map<String, dynamic>? _lastRemovedTask;
  int? _lastRemovedTaskIndex;

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

    _recalculateCounts();
    notifyListeners();
  }

  void checkTask(Map<String, dynamic> task) {
    task["done"] = !task["done"];
    _recalculateCounts();
    notifyListeners();
  }

  void removeTask(Map<String, dynamic> task) {
    _lastRemovedTaskIndex = todoList.indexOf(task);
    _lastRemovedTask = task;
    todoList.remove(task);
    _recalculateCounts();
    notifyListeners();
  }

  void undoRemove() {
    if (_lastRemovedTask != null && _lastRemovedTaskIndex != null) {
      todoList.insert(_lastRemovedTaskIndex!, _lastRemovedTask!);
      _recalculateCounts();
      notifyListeners();
    }
  }

  void _recalculateCounts() {
    todoCount = todoList.where((task) => !task["done"]).length;
    finishedCount = todoList.where((task) => task["done"]).length;
  }
}
