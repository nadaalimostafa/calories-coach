import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFoodData extends StatelessWidget {
  final String text;
  final String foodData;
  const TextFoodData({ required this.text,required this.foodData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( text ,
            style: Theme.of(context).textTheme.titleMedium,

          ),
          Text(foodData)
        ],
      ),
    );
  }
}
