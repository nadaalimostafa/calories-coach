import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  SettingProvider() {
    getTheme();
  }

  void changeTheme(ThemeMode theme) {
    if (theme == themeMode) return;
    themeMode = theme;
    saveTheme(theme);
    notifyListeners();
  }

  String language = "en";

  void changeLanguage(String newLanguage) {
    if (language == newLanguage) return;
    language = newLanguage;
    saveLanguage(newLanguage);
    notifyListeners();
  }

  Future<void> saveTheme(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme == ThemeMode.light ? "light" : "dark");
  }

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedTheme = prefs.getString("theme") ?? "light";
    themeMode = cachedTheme == "light" ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Future<void> saveLanguage(String updatedLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", updatedLanguage);
  }

  Future<void> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString("language") ?? "en";
    notifyListeners();
  }

  Future<void> saveWater(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("updateWater", value); // حفظ كمية الماء
    prefs.setString("lastUpdateTime", DateTime.now().toIso8601String());
  }
  Future<int> getUpdatesWater() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int updatesWater = prefs.getInt("updateWater") ?? 0;
    return updatesWater;
  }
  Future<void> saveSteps( int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("updateSteps", value); // Save steps
    prefs.setString("lastStepsUpdateTime", DateTime.now().toIso8601String());
  }

  Future<int> getUpdatesSteps() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int updatesSteps = prefs.getInt("updateSteps") ?? 0;
    return updatesSteps;
  }
  Future<void> saveCalories( int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("updateCalories", value); // Save steps
    prefs.setString("lastCaloriesUpdateTime", DateTime.now().toIso8601String());
  }

  Future<int> getCalories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int updateCalories = prefs.getInt("updateCalories") ?? 0;
    return updateCalories;
  }
  Future<void> saveCarb( int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("updateCarb", value); // Save steps
    prefs.setString("lastCarbUpdateTime", DateTime.now().toIso8601String());
  }

  Future<int> getCarb() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int updateCarb = prefs.getInt("updateCarb") ?? 0;
    return updateCarb;
  }
  Future<void> saveProtein( int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("updateProtein", value); // Save steps
    prefs.setString("lastProteinUpdateTime", DateTime.now().toIso8601String());
  }

  Future<int> getProtein() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int updateProtein = prefs.getInt("updateProtein") ?? 0;
    return updateProtein;
  }
  Future<void> saveFats( int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("updateFats", value); // Save steps
    prefs.setString("lastFatsUpdateTime", DateTime.now().toIso8601String());
  }

  Future<int> getFats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int updatesFats = prefs.getInt("updateFats") ?? 0;
    return updatesFats;
  }
}