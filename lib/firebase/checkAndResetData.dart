// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<void> checkAndResetData(String userId) async {
//   try {
//     final now = DateTime.now();
//     final formattedDate =
//         "${now.year}_${now.month <= 9 ? '0${now.month}' : now.month}_${now.day <= 9 ? '0${now.day}' : now.day}";
//
//     // // استرجاع البيانات من Firestore
//     // final snapshot = await FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(userId)
//     //     .collection('daily_progress')
//     //     .doc(formattedDate)
//     //     .get();
//     final prefs = await SharedPreferences.getInstance();
//     int calories = prefs.getInt("updateCalories") ?? 0;
//     int water = prefs.getInt("updateWater") ?? 0;
//     int carbohydrates = prefs.getInt("updateCarb") ?? 0;
//     int protein = prefs.getInt("updateProtein") ?? 0;
//     int fat = prefs.getInt("updateFats") ?? 0;
//     int steps = prefs.getInt("updateSteps") ?? 0;
//       await FirebaseFirestore.instance
//           .collection('User')
//           .doc(userId)
//           .collection('daily_progress')
//           .doc(formattedDate)
//           .set({
//         'calories': calories,
//         'water': water,
//         'carbohydrates': carbohydrates,
//         'protein': protein,
//         'fat': fat,
//         'steps': steps,
//         'date': formattedDate,
//       });
//
//   } catch (e) {
//     // التعامل مع الأخطاء
//     print("❌ خطأ أثناء استرجاع أو إعادة تعيين البيانات اليومية: $e");
//   }
// }
