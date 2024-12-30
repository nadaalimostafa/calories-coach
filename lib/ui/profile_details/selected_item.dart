
import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget{
    String title;
 SelectedItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style:Theme.of(context).textTheme. titleMedium!.copyWith(
              fontSize: 25,
            ),
          ),
        ),
        Icon(Icons.check,
        color: Theme.of(context).colorScheme.tertiary,
        size: 32,
       )
      ],
    );
  }                                                                                                                                         

}