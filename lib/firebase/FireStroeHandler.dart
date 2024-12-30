import 'dart:async';

import 'package:calories_coach/firebase/model/DailyTracking.dart';
import 'package:calories_coach/firebase/model/GetResult.dart';
import 'package:calories_coach/firebase/model/addFood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'model/goals.dart';
import 'model/user.dart';

class FireStoreHandler {
  static CollectionReference<User> getUserCollection() {
    var collection = FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, optional) {
        var data = snapshot.data();
        return User.fromFireStore(data);
      },
      toFirestore: (User user, options) {
        return user.toFireStore();
      },
    );
    return collection;
  }
  static Future<void> createUser(User user) async {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    await docRef.set(user);
  }
  static Future<User?> getUser(String userId) async {
    var collection = getUserCollection();
    var documentSnapshot = await collection.doc(userId).get();
    return documentSnapshot.data();
  }
  // Food Collection
  static CollectionReference<AddFood> getFoodCollection(String userId) {
    return getUserCollection().doc(userId).collection(AddFood.collectionName)
        .withConverter<AddFood>(
      fromFirestore: (snapshot, optional) {
        var data = snapshot.data();
        return AddFood.fromFireStore(data!);
      },
      toFirestore: (AddFood food, options) => food.toFireStore(),
    );
  }
  static Future<void> createFood(String userId, AddFood food) async {
    var collection = getFoodCollection(userId);
    var existingFoods = await collection.get();
    if (existingFoods.docs.isEmpty) {
      var docRef = collection.doc();
      food.id = docRef.id;
      await docRef.set(food);
      return;
    }
    for (var doc in existingFoods.docs) {
      var existingFood = doc.data();
      existingFood.calories = (existingFood.calories ?? 0) + (food.calories ?? 0);
      existingFood.carb = (existingFood.carb ?? 0) + (food.carb ?? 0);
      existingFood.fat = (existingFood.fat ?? 0) + (food.fat ?? 0);
      existingFood.protein = (existingFood.protein ?? 0) + (food.protein ?? 0);
      existingFood.water = (existingFood.water ?? 0 ) ;
      await collection.doc(doc.id).update(existingFood.toFireStore());
      return;
    }
    var docRef = collection.doc();
    food.id = docRef.id;
    await docRef.set(food);
  }
  static Stream<List<AddFood>> getFoodStream(String userId) {
    var collection = getFoodCollection(userId);
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }


  static Future<List<DailyTracking>> getMonthlyTrackingData(String userId, String month) async {
    try {
      DateTime now = DateFormat('yyyy-MM').parse(month);
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

      Timestamp startTimestamp = Timestamp.fromDate(startOfMonth);
      Timestamp endTimestamp = Timestamp.fromDate(endOfMonth);

      QuerySnapshot snapshot = await DailyTracking.getDailyTrackingCollection(userId)
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .where('date', isLessThanOrEqualTo: endTimestamp)
          .get();

      List<DailyTracking> monthlyData = [];
      snapshot.docs.forEach((doc) {
        monthlyData.add(DailyTracking.fromFireStore(doc.data() as Map<String, dynamic>));
      });

      return monthlyData;

    } catch (e) {
      print("Error getting monthly data: $e");
      return [];
    }
  }

}