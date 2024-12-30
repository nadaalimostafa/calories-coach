import 'package:calories_coach/firebase/model/DailyTracking.dart';
import 'package:calories_coach/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeekCard extends StatelessWidget {
  const WeekCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyTracking>>(
      future: DailyTracking.getDailyTracking(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, foodSnapshot) {

        List<BarChartGroupData> barChartData = [];

        if (foodSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (foodSnapshot.hasError) {
          return Center(child: Text("Error: ${foodSnapshot.error}"));
        }

        if (foodSnapshot.hasData && foodSnapshot.data!.isNotEmpty) {
          int dayIndex = 0;

          for (var tracking in foodSnapshot.data!) {
            barChartData.add(
              BarChartGroupData(
                x: dayIndex,
                barRods: [
                  BarChartRodData(
                    toY: tracking.waterTracking?.toDouble() ?? 0.0,
                    color: Colors.blue,
                    width: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  BarChartRodData(
                    toY: tracking.caloriesTracking?.toDouble() ?? 0.0,
                    color: Colors.green,
                    width: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // BarChartRodData(
                  //   toY: tracking.carbTracking?.toDouble() ?? 0.0,
                  //   color: Colors.orange,
                  //   width: 10,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  // BarChartRodData(
                  //   toY: tracking.fatsTracking?.toDouble() ?? 0.0,
                  //   color: Colors.red,
                  //   width: 10,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  // BarChartRodData(
                  //   toY: tracking.proteinTracking?.toDouble() ?? 0.0,
                  //   color: Colors.yellow,
                  //   width: 10,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),        gridData: FlGridData(show: false),
                  BarChartRodData(
                    toY: tracking.stepsTracking?.toDouble() ?? 0.0,
                    color: Colors.purple,
                    width: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            );
            dayIndex++;
          }
        }

        return SizedBox(
          height: 0.4 * MediaQuery.of(context).size.height, // لتحديد حجم الرسم البياني
          width: double.infinity,
          child: Card(
            color: AppColor.lightSecondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Weekly Tracking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),

                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: getBottomTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: barChartData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = '';
    switch (value.toInt()) {
      case 0:
        text = 'SUN';
        break;
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'T';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'T';
        break;
      case 5:
        text = 'Fri';
        break;
      default:
        text = '';
    }

    return Text(text, style: style);
  }
}
