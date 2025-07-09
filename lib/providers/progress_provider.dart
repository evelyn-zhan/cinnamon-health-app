import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ProgressProvider with ChangeNotifier {
  double currentWeight = 60.0;
  List<WeightEntry> weightHistory = [];
  int cumulativeLoggedDays = 0;

  late DateTime simulatedToday;

  ProgressProvider() {
    simulatedToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    initializeDummyWeightHistory();
    cumulativeLoggedDays = weightHistory.length;
  }

  void initializeDummyWeightHistory() {
    if (weightHistory.isEmpty) {
      for (int i = 6; i >= 0; i--) {
        DateTime date = simulatedToday.subtract(Duration(days: i));
        double dummyWeight = currentWeight + (i * 0.5) - 3.0;
        if (dummyWeight < 55.0) dummyWeight = 55.0;
        if (dummyWeight > 65.0) dummyWeight = 65.0;
        weightHistory.add(WeightEntry(date, dummyWeight));
      }
      sortAndTrimWeightHistory();
    }
  }

  void sortAndTrimWeightHistory() {
    weightHistory.sort((a, b) => a.date.compareTo(b.date));

    if (weightHistory.length > 7) {
      weightHistory = weightHistory.sublist(weightHistory.length - 7);
    }
  }

  List<FlSpot> get weightSpots {
    List<FlSpot> spots = [];
    for (int i = 0; i < weightHistory.length; i++) {
      spots.add(FlSpot(i.toDouble(), weightHistory[i].weight));
    }

    while (spots.length < 7) {
      double lastWeight = spots.isNotEmpty ? spots.last.y : currentWeight;
      spots.add(FlSpot(spots.length.toDouble(), lastWeight));
    }
    return spots;
  }

  List<String> getDateLabels() {
    List<String> labels = [];
    final DateFormat formatter = DateFormat('MMM d');

    DateTime startDate;
    if (weightHistory.isNotEmpty) {
      startDate = weightHistory.first.date;
    } else {
      startDate = simulatedToday.subtract(Duration(days: 6));
    }

    for (int i = 0; i < 7; i++) {
      labels.add(formatter.format(startDate.add(Duration(days: i))));
    }
    return labels;
  }

  void logWeight(double weight) {
    currentWeight = weight;

    simulatedToday = simulatedToday.add(Duration(days: 1));

    DateTime normalizedLogDate = DateTime(simulatedToday.year, simulatedToday.month, simulatedToday.day);

    bool updatedExisting = false;
    for (int i = 0; i < weightHistory.length; i++) {
      if (
        weightHistory[i].date.year == normalizedLogDate.year
        && weightHistory[i].date.month == normalizedLogDate.month
        && weightHistory[i].date.day == normalizedLogDate.day
      ) {
        weightHistory[i].weight = weight;
        updatedExisting = true;
        break;
      }
    }

    if (!updatedExisting) {
      weightHistory.add(WeightEntry(normalizedLogDate, weight));
      cumulativeLoggedDays++;
    }

    sortAndTrimWeightHistory();
    notifyListeners();
  }
}

class WeightEntry {
  final DateTime date;
  double weight;

  WeightEntry(this.date, this.weight);
}
