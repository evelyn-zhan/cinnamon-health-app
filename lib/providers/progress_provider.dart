import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ProgressProvider with ChangeNotifier {
  double _currentWeight = 60.0;
  List<WeightEntry> _weightHistory = [];
  int _cumulativeLoggedDays = 0;

  late DateTime _simulatedToday;

  ProgressProvider() {
    _simulatedToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _initializeDummyWeightHistory();
    _cumulativeLoggedDays = _weightHistory.length;
  }

  void _initializeDummyWeightHistory() {
    if (_weightHistory.isEmpty) {
      for (int i = 6; i >= 0; i--) {
        DateTime date = _simulatedToday.subtract(Duration(days: i));
        double dummyWeight = _currentWeight + (i * 0.5) - 3.0;
        if (dummyWeight < 55.0) dummyWeight = 55.0;
        if (dummyWeight > 65.0) dummyWeight = 65.0;
        _weightHistory.add(WeightEntry(date, dummyWeight));
      }
      _sortAndTrimWeightHistory();
    }
  }

  void _sortAndTrimWeightHistory() {
    _weightHistory.sort((a, b) => a.date.compareTo(b.date));

    if (_weightHistory.length > 7) {
      _weightHistory = _weightHistory.sublist(_weightHistory.length - 7);
    }
  }

  double get currentWeight => _currentWeight;

  int get totalWorkoutsDone => _cumulativeLoggedDays;

  List<FlSpot> get weightSpots {
    List<FlSpot> spots = [];
    for (int i = 0; i < _weightHistory.length; i++) {
      spots.add(FlSpot(i.toDouble(), _weightHistory[i].weight));
    }

    while (spots.length < 7) {
      double lastWeight = spots.isNotEmpty ? spots.last.y : _currentWeight;
      spots.add(FlSpot(spots.length.toDouble(), lastWeight));
    }
    return spots;
  }

  List<String> getDateLabels() {
    List<String> labels = [];
    final DateFormat formatter = DateFormat('MMM d');

    DateTime startDate;
    if (_weightHistory.isNotEmpty) {
      startDate = _weightHistory.first.date;
    } else {
      startDate = _simulatedToday.subtract(Duration(days: 6));
    }

    for (int i = 0; i < 7; i++) {
      labels.add(formatter.format(startDate.add(Duration(days: i))));
    }
    return labels;
  }

  void logWeight(double weight) {
    _currentWeight = weight;

    _simulatedToday = _simulatedToday.add(Duration(days: 1));

    DateTime normalizedLogDate = DateTime(
        _simulatedToday.year, _simulatedToday.month, _simulatedToday.day);

    bool updatedExisting = false;
    for (int i = 0; i < _weightHistory.length; i++) {
      if (_weightHistory[i].date.year == normalizedLogDate.year &&
          _weightHistory[i].date.month == normalizedLogDate.month &&
          _weightHistory[i].date.day == normalizedLogDate.day) {
        _weightHistory[i].weight = weight;
        updatedExisting = true;
        break;
      }
    }

    if (!updatedExisting) {
      _weightHistory.add(WeightEntry(normalizedLogDate, weight));
      _cumulativeLoggedDays++;
    }

    _sortAndTrimWeightHistory();
    notifyListeners();
  }
}

class WeightEntry {
  final DateTime date;
  double weight;

  WeightEntry(this.date, this.weight);
}
