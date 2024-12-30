import 'package:calories_coach/style/app_color.dart';
import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  final String text;
  //final TextStyle textStyle;
  final Color backgroundButtonColor;
  final Function() onPressed;

  CustomSmallButton({
    required this.onPressed,
    required this.text,
   // required this.textStyle,
    required this.backgroundButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style:  Theme.of(context).textTheme.titleMedium,
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(90,30),
        maximumSize: Size(120, 60),
        backgroundColor: backgroundButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
