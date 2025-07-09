import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_mobile_app/providers/todo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController taskTitleC = TextEditingController();

  List<String> categories = ["Fitness", "Nutrition", "Self Care", "Other"];
  String? taskCategory = "Fitness";

  DateTime? selectedDate;
  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0369A1),
              onPrimary: Colors.white,
              onSurface: Colors.black
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF0369A1),
                foregroundColor: Colors.white
              )
            )
          ),
          child: child!
        );
      }
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      selectTime();
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0369A1),
              onPrimary: Colors.white,
              onSurface: Colors.black
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF0369A1),
                foregroundColor: Colors.white
              )
            )
          ),
          child: child!
        );
      }
    );

    if (pickedTime != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          pickedTime.hour,
          pickedTime.minute
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                taskTitleC.clear();
                taskCategory = "Fitness";
              });
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, size: 30)
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: taskTitleC,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "New Task",
                    hintStyle: GoogleFonts.poppins(color: Color(0xFF898989), fontSize: 15, fontWeight: FontWeight.w600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC8C8C8), width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC8C8C8), width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)
                ),
                SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...categories.map((category) {
                        return Row(
                          children: [
                            Radio(
                              value: category,
                              groupValue: taskCategory,
                              activeColor: Color(0xFF0369A1),
                              onChanged: (value) {
                                setState(() {
                                  taskCategory = value;
                                });
                              }
                            ),
                            Text(category, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                            SizedBox(width: 12)
                          ]
                        );
                      })
                    ]
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Date: ${selectedDate == null ? "Not Set" : DateFormat("dd MMM yyyy, HH:mm").format(selectedDate!)}",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)
                    ),
                    ElevatedButton.icon(
                      onPressed: () => selectDate(),
                      icon: Icon(Icons.calendar_month_rounded, color: Colors.white, size: 20),
                      label: Text("Select Date", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          taskTitleC.text = "";
                        });
                      },
                      icon: Icon(Icons.clear_rounded, color: Colors.white, size: 20),
                      label: Text("Clear", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (taskTitleC.text.isNotEmpty) {
                          context.read<TodoProvider>().addTask(taskTitleC.text, taskCategory, DateFormat("dd MMM yyyy, HH:mm").format(selectedDate!));
                          taskTitleC.text = "";
                          taskCategory = "Fitness";
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.add_rounded, color: Colors.white, size: 20),
                      label: Text("Add", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      )
                    )
                  ]
                )
              ]
            )
          )
        ]
      )
    );
  }
}