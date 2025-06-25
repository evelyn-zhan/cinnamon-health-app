import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({super.key, required this.task});

  final Map<String, dynamic> task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(color: Theme.of(context).shadowColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task["title"],
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(task["category"],
                  style: GoogleFonts.poppins(
                      color: task["color"],
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: task["done"],
                activeColor: const Color(0xFF212121),
                onChanged: (value) {
                  context.read<TodoProvider>().checkTask(task);
                },
              ),
              IconButton(
                onPressed: () => _showDeleteConfirmation(context, task),
                icon: Icon(Icons.delete_rounded,
                    color: Theme.of(context).iconTheme.color, size: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi penghapusan
  Future<void> _showDeleteConfirmation(
      BuildContext context, Map<String, dynamic> task) async {
    final todoProvider = context.read<TodoProvider>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          //--- Perubahan untuk Dialog ---//
          backgroundColor: Theme.of(context).canvasColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text('Delete Confirmation',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, color: const Color(0xFF212121))),
          content: Text('Are you sure you want to delete this task?',
              style: GoogleFonts.poppins(color: const Color(0xFF555555))),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(
                    0xFF898989), // Warna abu-abu untuk aksi sekunder
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text('Cancel',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(
                    0xFFD32F2F), // Warna merah untuk menandakan bahaya (delete)
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog first
                todoProvider.removeTask(task); // Perform the task removal

                // Remove any current snackbar before showing a new one
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    //--- Perubahan untuk SnackBar ---//
                    content: Text(
                      'Task has been deleted.',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    backgroundColor:
                        const Color(0xFF212121), // Warna hitam aksen utama
                    behavior: SnackBarBehavior
                        .floating, // Membuat snackbar mengambang
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    duration:
                        const Duration(seconds: 3), // Durasi tampil snackbar
                    action: SnackBarAction(
                      label: 'UNDO',
                      // Warna kuning dari kategori 'Self Care' agar menonjol
                      textColor: const Color(0xFFCA8A04),
                      onPressed: () {
                        todoProvider.undoRemove(); // Undo the task removal
                      },
                    ),
                  ),
                );
              },
              child: Text('Sure',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }
}
