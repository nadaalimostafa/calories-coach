import 'package:flutter/material.dart';

class TextWaterWidget extends StatelessWidget {
  String text;

  TextWaterWidget(this.text);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18),
    );
  }
}
