
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
typedef validationFunction = String? Function(String?);
class CustomTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool isPassword;
  final String label;
  final validationFunction validator;
  const CustomTextFiled({
    required this.controller,
    required this.keyboard,
    this.isPassword = false,
    required this.label,
    required this.validator,

  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
 bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller:widget.controller ,
        keyboardType: widget.keyboard,
        validator: widget.validator,
        obscureText: widget.isPassword
        ?isVisible
        :false,
        style: Theme.of(context).textTheme.labelSmall,
        autofocus: true,

      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.labelSmall,
        suffixIcon: widget.isPassword
              ?IconButton(
              onPressed: (){
                setState(() {
                  isVisible = !isVisible;
                });
              },
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
        )
            : null,
        ),
    );

  }
}