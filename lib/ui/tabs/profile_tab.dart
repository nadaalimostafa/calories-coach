import 'package:calories_coach/providers/setting_provider.dart';
import 'package:calories_coach/screens/log_in_screen.dart';
import 'package:calories_coach/ui/profile_details/language_bottom_sheet.dart';
import 'package:calories_coach/ui/profile_details/theme_buttom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../firebase/FireStroeHandler.dart';
import '../profile_details/EditProfile.dart';

class ProfileTab extends StatelessWidget {
  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context,  LogInScreen.routeName);
    } catch (e) {
      print("Error loging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return FutureBuilder(
        future: FireStoreHandler.getUser(FirebaseAuth.instance.currentUser!.uid),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
    return Center(child: Text("Error: ${snapshot.error}"));
    }
    return Container(
    margin: EdgeInsets.symmetric(vertical: height*0.06 ,
    horizontal:width*0.04),
    child: Column(
    children: [
    Text(
    "Profile",
    style:Theme.of(context).textTheme.titleLarge,
    textAlign: TextAlign.center,
    ),
    //profile Text
    SizedBox(height: height * 0.02),

    Center(
    child: CircleAvatar(
    radius: width * 0.15,
    backgroundColor: Colors.grey[200],
    child: Image.asset(
    "assets/images/Ellipse 8.png",
    fit: BoxFit.fill,
    )),
    ),
    //Photo Profile
    SizedBox(height: height * 0.02),
    Text(
    "${snapshot.data?.fullName}",
    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
    ),
    //Profile Name
    SizedBox(height: height * 0.05),

    Row(
    children: [
    Icon(
    settingProvider.themeMode == ThemeMode.dark
    ? Icons.nightlight_round
        : Icons.wb_sunny,
    color: Theme.of(context).colorScheme.onSecondary,
    ),
    SizedBox(width: width * 0.2),
    InkWell(
    onTap: () {
    showModalBottomSheet(
    context: context,
    builder: (context) => ThemeButtomSheet(),
    backgroundColor: Theme.of(context).colorScheme.primary,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)));
    },
    child: Text(
    settingProvider.themeMode == ThemeMode.dark
    ? AppLocalizations.of(context)!.dark
        : AppLocalizations.of(context)!.light,
    style:Theme.of(context).textTheme. titleMedium!.copyWith(
    fontSize: 20,
    ),
    ),
    )
    ],
    ),
    //Theme Mode
    SizedBox(height: height * 0.04),
    //language Mode
    Row(
    children: [
    Icon(
    Icons.language,
    color: Theme.of(context).colorScheme.onSecondary,
    ),
    SizedBox(width: width * 0.2),
    InkWell(
    onTap: () {
    showModalBottomSheet(
    context: context,
    builder: (context) => LanguageBottomSheet(),
    backgroundColor: Theme.of(context).colorScheme.primary,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)));
    },
    child: Text(
    settingProvider.language == "ar" ? "العربية" : "English",
    textAlign: TextAlign.center,
    style:Theme.of(context).textTheme. titleMedium!.copyWith(
    fontSize: 20,
    ),
    ),
    ),

    ],
    ), SizedBox(height: height * 0.04),

    Row(
    children: [
    Icon(
    Icons.logout_outlined,
    color: Theme.of(context).colorScheme.onSecondary,
    ),
    SizedBox(width: width * 0.2),

    InkWell(
    onTap: () {
    logOut(context);
    },
    child: Text(
    "Log Out",

    style: Theme.of(context).textTheme. titleMedium!.copyWith(
    fontSize: 20,
    ),
    ),
    ),
    ],
    ),
      SizedBox(height: height*0.05),
      Row(
        children: [
          Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          SizedBox(width: width * 0.2),

          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => EditProfile(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))
              );
            },
            child: Text(
              "Edit Profile ",
              style: Theme.of(context).textTheme. titleMedium!.copyWith(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    ],

    ),
    );
    });


  }
}
