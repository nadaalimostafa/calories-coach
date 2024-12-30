
import 'package:calories_coach/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnselectedItem extends StatelessWidget{
  String title;
  UnselectedItem(this.title); 
  @override
  Widget build(BuildContext context) {
   SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge,);
  }
}