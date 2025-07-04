// lib/providers/page_provider.dart
import 'package:flutter/material.dart';
import 'package:health_mobile_app/screens/articles.dart';
import 'package:health_mobile_app/screens/home.dart';
import 'package:health_mobile_app/screens/progress.dart';
import 'package:health_mobile_app/screens/todo.dart';

class PageProvider with ChangeNotifier {
  int pageIndex = 0;
  List<Widget> page = [
    Home(),
    Articles(),
    ToDo(),
    ProgressTrackerScreen(), // Tambahkan layar ProgressTrackerScreen di sini
  ];
  String pageName = "";

  void changePage(int index) {
    pageIndex = index;
    if (pageIndex == 1) {
      pageName = "Articles";
    } else if (pageIndex == 2) {
      pageName = "My Tasks";
    } else if (pageIndex == 3) {
      pageName = "Progress"; // Sesuaikan nama untuk indeks 3
    } else {
      pageName = ""; // Untuk indeks 0 (Home)
    }
    notifyListeners();
  }

  // Metode addPage yang sebelumnya saya sarankan tidak lagi diperlukan di sini
  // karena semua halaman sudah didefinisikan secara statis di dalam list 'page'.
  // Jika Anda ingin fleksibilitas untuk menambahkan halaman secara dinamis di masa mendatang,
  // Anda bisa mempertimbangkan untuk mengembalikannya.
}
