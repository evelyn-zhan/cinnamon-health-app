// progress.dart (ini sama dengan yang terakhir kali saya berikan)

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:health_mobile_app/providers/progress_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProgressTrackerScreen extends StatefulWidget {
  @override
  _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController.text =
        Provider.of<ProgressProvider>(context, listen: false)
            .currentWeight
            .toStringAsFixed(1);
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color fitnessColor = Color(0xFF0369A1);
    final Color nutritionColor = Color(0xFF16A34A);
    final Color selfCareColor = Color(0xFFCA8A04);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Progress',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            fitnessColor.withOpacity(0.2),
                            fitnessColor.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: fitnessColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Progress Streak (Days)',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: fitnessColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            // Ini adalah bagian yang mengambil nilai dari provider
                            '${progressProvider.totalWorkoutsDone}', // Mengambil dari getter yang dimodifikasi
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: fitnessColor.withOpacity(0.7),
                            ),
                          ),
                          Icon(
                            Icons.local_fire_department,
                            size: 40,
                            color: Color(0xFFFF4500).withOpacity(0.7),
                          ),
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
                          iconAsset: 'assets/images/shoe-icon.png',
                          title: 'Steps',
                          value: '3,200',
                          valueSuffix: 'steps',
                          valueColor: nutritionColor,
                          backgroundColor: Theme.of(context).canvasColor,
                          shadowColor: Theme.of(context).shadowColor,
                        ),
                        SizedBox(height: 15),
                        ExerciseCard(
                          iconAsset: 'assets/images/mineral-water.png',
                          title: 'Water',
                          value: '1.5',
                          valueSuffix: 'Litres',
                          valueColor: fitnessColor,
                          backgroundColor: Theme.of(context).canvasColor,
                          shadowColor: Theme.of(context).shadowColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Body Weight',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current (kg)',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        TextField(
                          controller: _weightController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText: 'Enter weight',
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: selfCareColor,
                          ),
                          onSubmitted: (value) {
                            double? weight = double.tryParse(value);
                            if (weight != null) {
                              progressProvider.logWeight(weight);
                            }
                          },
                        ),
                        Divider(
                          color: Colors.grey[400],
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      double? newWeight =
                          double.tryParse(_weightController.text);
                      if (newWeight != null) {
                        progressProvider.logWeight(newWeight);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Please enter a valid number for weight.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selfCareColor.withOpacity(0.1),
                      foregroundColor: selfCareColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'LOG',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Progress in the Last 7 Days',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        mainData(
                          progressProvider.weightSpots,
                          progressProvider.getDateLabels(),
                          fitnessColor,
                          nutritionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData mainData(List<FlSpot> spots, List<String> dateLabels,
      Color lineColor1, Color lineColor2) {
    double minYValue = 0;
    double maxYValue = 0;

    if (spots.isNotEmpty) {
      minYValue = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
      maxYValue = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    } else {
      minYValue = 55;
      maxYValue = 65;
    }

    minYValue = (minYValue - 2).floorToDouble();
    maxYValue = (maxYValue + 2).ceilToDouble();

    if (maxYValue - minYValue < 5) {
      final center = (minYValue + maxYValue) / 2;
      minYValue = center - 2.5;
      maxYValue = center + 2.5;
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xfff3f3f3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xfff3f3f3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 45,
            interval: 1,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
              int index = value.toInt();
              String text;
              if (index >= 0 && index < dateLabels.length) {
                text = dateLabels[index];
              } else {
                text = '';
              }
              return SideTitleWidget(
                child: Text(text, style: style, textAlign: TextAlign.center),
                meta: meta,
                space: 15.0,
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            interval: 1,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: Color(0xff67727d),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
              if (value % 1 == 0) {
                return Text(value.toInt().toString(),
                    style: style, textAlign: TextAlign.left);
              }
              return Container();
            },
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xffececec), width: 1),
      ),
      minX: 0,
      maxX: 6,
      minY: minYValue,
      maxY: maxYValue,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              lineColor1,
              lineColor2,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: lineColor1,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                lineColor1.withOpacity(0.3),
                lineColor2.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

// ExerciseCard (tetap sama)
class ExerciseCard extends StatelessWidget {
  final String? iconAsset;
  final String title;
  final String value;
  final String valueSuffix;
  final Color backgroundColor;
  final Color valueColor;
  final Color shadowColor;

  const ExerciseCard({
    Key? key,
    required this.iconAsset,
    required this.title,
    required this.value,
    required this.valueSuffix,
    required this.backgroundColor,
    required this.valueColor,
    required this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 11),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$value ',
                      style: GoogleFonts.poppins(
                        color: valueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: valueSuffix,
                      style: GoogleFonts.poppins(
                        color: Color(0xFF898989),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          if (iconAsset != null) Image.asset(iconAsset!, width: 30, height: 30),
        ],
      ),
    );
  }
}
