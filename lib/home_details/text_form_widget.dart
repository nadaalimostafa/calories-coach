import 'package:calories_coach/style/reusable_components/custom_text_filed.dart';
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final TextInputType keyboard;
  final TextEditingController controller;
  final validationFunction validation;
  final String labelText;
  TextFormWidget(
      {required this.keyboard,
      required this.controller,
      required this.validation,
      required this.labelText,
     });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      validator: validation,
      decoration: InputDecoration(
        labelText:labelText ,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        border: OutlineInputBorder(),
      ),
    );
  }
}
