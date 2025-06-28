import 'package:flutter/material.dart';
import 'package:health_mobile_app/components/add_task_bottom_sheet.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          // backgroundColor: Color(0xFFFAFAFA),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          context: context,
          builder: (context) => AddTaskBottomSheet()
        );
      },
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Icon(Icons.add_rounded, size: 30)
    );
  }
}