import 'package:calories_coach/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColor.lightPrimaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColor.labelSmallColor,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.lightPrimaryColor,
      unselectedItemColor: AppColor.textMedium,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.lightPrimaryColor,
        shape: StadiumBorder(side: BorderSide(color: AppColor.lightSecondary))),

    useMaterial3: false,

    textTheme: TextTheme(
        labelSmall: GoogleFonts.getFont(
          'Fjalla One',
          color: AppColor.labelSmallColor,
          fontSize: 12,


        ),
        labelMedium: GoogleFonts.getFont(
          'Fjalla One',
          fontSize: 22,
        ),

        titleLarge: GoogleFonts.getFont(
            'Fjalla One',
            fontSize: 20,
            color: AppColor.titleColor
        ),
        titleMedium: GoogleFonts.getFont(
            'Fjalla One',
          fontSize: 17,
          color: AppColor.textMedium,
            fontWeight: FontWeight.bold

        ),
        bodyLarge: GoogleFonts.getFont(
            'Fjalla One',
            fontSize: 17,
            color: AppColor.textMedium,


        ),
        labelLarge: GoogleFonts.getFont(
            'Fjalla One',
            fontSize: 25,
            color: AppColor.lightSecondary
        )),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.lightPrimaryColor,
      primary: AppColor.lightPrimaryColor,
      secondary: AppColor.backgroundTextForm,
      outline: AppColor.titleColor,
      onSecondary: AppColor.IconColor,
      tertiary: AppColor.textMedium,
      onTertiary: AppColor.lightSecondary,
    ),

    cardTheme:  CardTheme(
      color: AppColor.lightPrimaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),

      ),


    ),
    appBarTheme: const AppBarTheme(

        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        )),
    scaffoldBackgroundColor: AppColor.lightSecondary,

  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.titleColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColor.lightPrimaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColor.labelSmallColor,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.lightPrimaryColor,
      unselectedItemColor: AppColor.titleColor,
    ),

    // Update properties for dark theme here
    textTheme: const TextTheme(
      // Update text styles for dark theme
      labelSmall: TextStyle(color: Colors.white70, fontSize: 12),
      labelMedium: TextStyle(fontSize: 22),
      titleLarge: TextStyle(fontSize: 25, color: Colors.white),
      titleMedium: TextStyle(fontSize: 17, color: Colors.white70),
      labelLarge: TextStyle(fontSize: 25, color: Colors.white54),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      primary: AppColor.lightPrimaryColor,
      secondary: const Color(0xFF303030), // Adjust based on your app's colors
      outline: Colors.white70,
      onSecondary: Colors.white,
      tertiary: Colors.white70,
      onTertiary: AppColor.titleColor,
    ),

    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
