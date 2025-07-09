import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartData getWeightChartData(List<FlSpot> spots, List<String> dateLabels, Color lineColor1, Color lineColor2) {
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
              text = "";
            }
            return SideTitleWidget(
              meta: meta,
              space: 15.0,
              child: Text(text, style: style, textAlign: TextAlign.center)
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
    lineTouchData: LineTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            return LineTooltipItem(
              spot.y.toStringAsFixed(1),
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            );
          }).toList();
        },
      ),
    ),
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