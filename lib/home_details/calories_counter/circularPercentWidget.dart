import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularPercentwidget extends StatelessWidget {
   Color progressColor;
   Color backgroundColor;
   double progress ;
  double radius ;
  String centerText;
   TextStyle style;
  String? text;
  double lineWidth;
   IconData? icon;
   double? iconSize;

   CircularPercentwidget({
    required this.backgroundColor,
    required this.progressColor ,
    required this.progress,
    required this.radius,
     required this . lineWidth,
     required this.centerText,
     required this.style,
    this.text,
    this.iconSize,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
   return CircularPercentIndicator(
     radius: radius,
     lineWidth: lineWidth,
     animation: true,
     animationDuration: 1500,
     percent: progress > 1.0 ? 1.0 : progress,
     center: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
          Icon(icon,size: iconSize,),
         Text(
           centerText,
           style:style),

         Text(
           text?? " ",
           style: TextStyle(fontSize: 18, color: Colors.grey),
         ),
       ],
     ),
     progressColor:progressColor,
     backgroundColor:backgroundColor,
     circularStrokeCap: CircularStrokeCap.round,
   );
  }
}