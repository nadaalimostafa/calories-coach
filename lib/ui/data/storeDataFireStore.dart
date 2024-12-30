import 'package:calories_coach/firebase/model/DailyTracking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


@pragma('vm:entry-point')
class StoreDataFirestore {
  static Future<void>saveDataForestore() async {

    final dateFormate = Timestamp.fromDate(DateTime.now());
    try{
      final prefs = await SharedPreferences.getInstance();
      int calories = prefs.getInt("updateCalories") ?? 0;
      int water = prefs.getInt("updateWater") ?? 0;
      int carbohydrates = prefs.getInt("updateCarb") ?? 0;
      int protein = prefs.getInt("updateProtein") ?? 0;
      int fat = prefs.getInt("updateFats") ?? 0;
      int steps = prefs.getInt("updateSteps") ?? 0;

      DailyTracking.createDailyTracking(
          FirebaseAuth.instance.currentUser!.uid??"",
          DailyTracking(
            carbTracking: calories,
            waterTracking: water,
            caloriesTracking: carbohydrates,
            proteinTracking: protein,
            fatsTracking: fat,
            stepsTracking: steps,
            date: dateFormate,
          ));

    await prefs.setInt('updateCalories', 0);
    await prefs.setDouble('updateWater', 0.0);
    await prefs.setInt('updateCarb', 0);
    await prefs.setInt('updateProtein', 0);
    await prefs.setInt('updateFats', 0);
    await prefs.setInt('updateSteps', 0);

    }catch (e){
      print ("Can not store Dataaaaaaaaaaaaa!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

}
