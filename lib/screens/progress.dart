import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_mobile_app/components/exercise_card.dart';
import 'package:health_mobile_app/components/info_card.dart';
import 'package:health_mobile_app/utils/chart_data.dart';
import 'package:provider/provider.dart';
import 'package:health_mobile_app/providers/progress_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressTrackerScreen extends StatefulWidget {
  const ProgressTrackerScreen({super.key});

  @override
  ProgressTrackerScreenState createState() => ProgressTrackerScreenState();
}

class ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weightController.text = Provider.of<ProgressProvider>(context, listen: false).currentWeight.toStringAsFixed(1);
  }


  @override
  void dispose() {
    super.dispose();
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);

    final Color fitnessColor = Color(0xFF0369A1);
    final Color nutritionColor = Color(0xFF16A34A);
    final Color selfCareColor = Color(0xFFCA8A04);

    final List<Color> gradientColors = [Color(0xFFB8E6FE), Color(0xFFDFF2FE)];
    final Alignment beginGradient = Alignment.topLeft;
    final Alignment endGradient = Alignment.bottomRight;

    final double totalCaloriesBurned = 257.0;
    final double ramenCalories = 240.0;
    final double ramenEquivalent = totalCaloriesBurned / ramenCalories;

    final double totalDistanceKm = 6.42;
    final double bigBenHeight = 0.096;
    final double bigBenEquivalent = totalDistanceKm / bigBenHeight;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFffd6a8), Color(0xFFfff7ed)],
                          begin: beginGradient,
                          end: endGradient,
                        ),
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 1, blurRadius: 3, offset: Offset(0, 5))
                        ]
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Progress Streak (Days)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.deepOrange),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${progressProvider.cumulativeLoggedDays}",
                            style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.local_fire_department, size: 40, color: Colors.deepOrangeAccent),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ExerciseCard(
                          iconAsset: "assets/images/shoe-icon.png",
                          title: "Steps",
                          value: "3,200",
                          valueSuffix: "steps",
                          valueColor: nutritionColor
                        ),
                        SizedBox(height: 15),
                        ExerciseCard(
                          iconAsset: "assets/images/mineral-water.png",
                          title: "Water",
                          value: "1.5",
                          valueSuffix: "Litres",
                          valueColor: fitnessColor
                        )
                      ]
                    )
                  )
                ]
              ),
              SizedBox(height: 20),
              InfoCard(
                title: "Total calories burned",
                value: "${totalCaloriesBurned.toStringAsFixed(0)} kcal",
                comparisonText: "≈ ${ramenEquivalent.toStringAsFixed(2)} bowl(s) of Ramen",
                imageAsset: "assets/images/ramen.png",
                gradientColors: gradientColors
              ),
              SizedBox(height: 15),
              InfoCard(
                title: "Total distance",
                value: "${totalDistanceKm.toStringAsFixed(2)} km",
                comparisonText: "≈ Distance equivalent to climbing to\nthe top of Big Ben in Britain ${bigBenEquivalent.toStringAsFixed(2)} time(s)",
                imageAsset: "assets/images/big-ben.png",
                gradientColors: gradientColors
              ),
              SizedBox(height: 32),
              Text(
                "Body Weight",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Current (kg)", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                        TextField(
                          controller: weightController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText: "Enter weight",
                            hintStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[400]),
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: selfCareColor),
                          onSubmitted: (value) {
                            double? weight = double.tryParse(value);
                            if (weight != null) {
                              progressProvider.logWeight(weight);
                            }
                          },
                        ),
                        Divider(color: Colors.grey[400], thickness: 1, height: 1),
                      ]
                    )
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      double? newWeight = double.tryParse(weightController.text);
                      if (newWeight != null) {
                        progressProvider.logWeight(newWeight);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter a valid number for weight.")
                          )
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selfCareColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0
                    ),
                    child: Text("LOG", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                  )
                ]
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).shadowColor, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3))
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weight Progress in the Last 7 Days",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        getWeightChartData(
                          progressProvider.weightSpots,
                          progressProvider.getDateLabels(),
                          fitnessColor,
                          nutritionColor,
                        )
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
