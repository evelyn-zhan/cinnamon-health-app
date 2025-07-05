// lib/screens/progress_tracker_screen.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_mobile_app/components/exercise_card.dart';
import 'package:health_mobile_app/components/info_card.dart';
import 'package:health_mobile_app/utils/chart_data.dart';
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
    // Menginisialisasi teks controller dengan berat badan saat ini dari provider
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

    final Color fitnessColor = Color(0xFF0369A1); // Biru tua
    final Color nutritionColor = Color(0xFF16A34A); // Hijau tua
    final Color selfCareColor = Color(0xFFCA8A04); // Kuning/Coklat tua

    // --- Data Dummy untuk InfoCard ---
    // Anda bisa menggantinya dengan data nyata dari progressProvider jika sudah tersedia
    final double totalCaloriesBurned = 257.0;
    final double martabakManisCalories =
        240.0; // Kalori per 1 potong Martabak Manis (estimasi)
    final double martabakEquivalent =
        totalCaloriesBurned / martabakManisCalories;

    final double totalDistanceKm = 6.42;
    final double bigBenHeight = 0.096; // Tinggi Big Ben dalam km (96 meter)
    final double bigBenEquivalent = totalDistanceKm / bigBenHeight;
    // --- Akhir Data Dummy ---

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
                            '${progressProvider.totalWorkoutsDone}',
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
              SizedBox(height: 20),

              // --- Widget InfoCard untuk Calories Burned (menggunakan gradien 3 warna) ---
              InfoCard(
                title: 'Total calories burned',
                value: '${totalCaloriesBurned.toStringAsFixed(0)} kcal',
                comparisonText:
                    '≈${martabakEquivalent.toStringAsFixed(2)} piece(s) of Martabak Manis',
                imageAsset: 'assets/images/mineral-water.png',
                gradientColors: [
                  fitnessColor.withOpacity(0.2), // Mulai dengan biru pudar
                  nutritionColor
                      .withOpacity(0.1), // Transisi ke hijau lebih pudar
                  selfCareColor
                      .withOpacity(0.05), // Berakhir dengan kuning sangat pudar
                ],
                beginGradient: Alignment.topLeft,
                endGradient: Alignment.bottomRight,
                textColor: isDarkMode ? Colors.white : Colors.black,
                comparisonTextColor:
                    isDarkMode ? Colors.grey[400]! : Colors.grey[700]!,
              ),
              SizedBox(height: 15),
              // --- Widget InfoCard untuk Total Distance (menggunakan gradien 3 warna) ---
              InfoCard(
                title: 'Total distance',
                value: '${totalDistanceKm.toStringAsFixed(2)} km',
                // Teks perbandingan bisa dipecah baris secara manual jika terlalu panjang
                comparisonText:
                    '≈Distance equivalent to climbing to\nthe top of Big Ben in Britain ${bigBenEquivalent.toStringAsFixed(2)} time(s)',
                imageAsset: 'assets/images/mineral-water.png',
                gradientColors: [
                  selfCareColor
                      .withOpacity(0.05), // Mulai dengan kuning sangat pudar
                  nutritionColor
                      .withOpacity(0.1), // Transisi ke hijau lebih pudar
                  fitnessColor.withOpacity(0.2), // Berakhir dengan biru pudar
                ],
                beginGradient:
                    Alignment.bottomLeft, // Contoh arah gradien berbeda
                endGradient: Alignment.topRight,
                textColor: isDarkMode ? Colors.white : Colors.black,
                comparisonTextColor:
                    isDarkMode ? Colors.grey[400]! : Colors.grey[700]!,
              ),
              SizedBox(height: 30), // Spasi sebelum Body Weight

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
                        getWeightChartData(
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
}
