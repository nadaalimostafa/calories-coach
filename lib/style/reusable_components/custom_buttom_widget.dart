import 'package:calories_coach/style/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtomWidget extends StatelessWidget {
  final String buttom;
  final void Function() onClick;
  CustomButtomWidget({required this.buttom, required this.onClick});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.06,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClick, 
        style: ElevatedButton.styleFrom(
          // minimumSize:  Size(width*0.1, height*0.02), 
            backgroundColor: AppColor.lightPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                )),
        child: Text(
          buttom,
          style: Theme.of(context).textTheme.labelLarge, 
        ),
      ),
    );
  }
}
