
import 'package:calories_coach/providers/setting_provider.dart';
import 'package:calories_coach/ui/profile_details/selected_item.dart';
import 'package:calories_coach/ui/profile_details/unselected_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ThemeButtomSheet extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
   SettingProvider settingProvider = Provider.of<SettingProvider>(context);
       double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Container(
      height:height*0.25 ,
      padding : EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectedItem(settingProvider.themeMode == ThemeMode.dark
              ? AppLocalizations.of(context)!.dark
              : AppLocalizations.of(context)!.light),
          const SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                if (settingProvider.themeMode == ThemeMode.dark) {
                  settingProvider.changeTheme(ThemeMode.light);
                } else {
                  settingProvider.changeTheme(ThemeMode.dark);
                }
                Navigator.of(context).pop();
              },
              child: UnselectedItem(settingProvider.themeMode == ThemeMode.dark
                  ? AppLocalizations.of(context)!.light
                  : AppLocalizations.of(context)!.dark)),
        ],
      ),
    );
  }
}