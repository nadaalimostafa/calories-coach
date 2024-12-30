import 'package:calories_coach/food%20details/meal.dart.dart';
import 'package:calories_coach/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

class CustomFoodWidget extends StatelessWidget {
  String title;
  String imageName;

  CustomFoodWidget({required this.title, required this.imageName });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.1,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
      decoration: BoxDecoration(
         color: AppColor.container4,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topLeft,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
           title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),

        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/foodImages/$imageName',
            fit: BoxFit.cover,
            width: width * 0.16,
          ),
        )
      ]),
    );
  }

}
