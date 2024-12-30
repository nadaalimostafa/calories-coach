
import 'package:calories_coach/providers/setting_provider.dart';
import 'package:calories_coach/ui/profile_details/selected_item.dart';
import 'package:calories_coach/ui/profile_details/unselected_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget{
    

  @override
  Widget build(BuildContext context) {
     SettingProvider settingProvider = Provider.of<SettingProvider>(context);
            double height = MediaQuery.of(context).size.height;

    return Container(
     height:height*0.25 ,
      padding : EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         SelectedItem(
           settingProvider.language=="ar"
           ?"العربية"
           :"English"),
         SizedBox(
         height: 15,
          ),
         InkWell(
          onTap: (){
            settingProvider.language=="ar"
            ?settingProvider.changeLanguage("en") 
            :settingProvider.changeLanguage("ar");
          },
          child: UnselectedItem(
             settingProvider.language=="ar"
           ? "English"
           :"العربية"
          )),
        ],
      ),
    );
  }
}