import 'package:calories_coach/firebase/FireStroeHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyTracking {
  static const collectionName = "dailyTracking";
  int? stepsTracking;
  int? waterTracking;
  int? caloriesTracking;
  int? proteinTracking;
  int? carbTracking;
  int? fatsTracking;
  Timestamp? date;
  String? id;

  DailyTracking({
    this.stepsTracking,
    this.date,
    this.caloriesTracking,
    this.carbTracking,
    this.fatsTracking,
    this.proteinTracking,
    this.waterTracking,
    this.id,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "stepsTracking": stepsTracking,
      "caloriesTracking": caloriesTracking,
      "proteinTracking": proteinTracking,
      "carbTracking": carbTracking,
      "fatsTracking": fatsTracking,
      "waterTracking": waterTracking,
      "date": date,
      "id": id,
    };
  }
  DailyTracking.fromFireStore(Map<String, dynamic>? data) {
    date = data?["date"];
    waterTracking = data?["waterTracking"];
    fatsTracking = data?["fatsTracking"];
    carbTracking = data?["carbTracking"];
    caloriesTracking = data?["caloriesTracking"];
    stepsTracking = data?["stepsTracking"];
    proteinTracking = data?["proteinTracking"];
    id = data?["id"];
  }
  static CollectionReference<DailyTracking> getDailyTrackingCollection(String userId) {
    var collection = FireStoreHandler. getUserCollection().
    doc(userId)
        .collection(DailyTracking.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) {
        return DailyTracking.fromFireStore(snapshot.data());
      },
      toFirestore: (dailyTracking, options) {
        return dailyTracking.toFireStore();
      },
    );
    return collection;
  }
  static Future<void> createDailyTracking(String userId, DailyTracking dailyTracking) async {
      var collection = getDailyTrackingCollection(userId);
    var docRef = collection.doc();
    dailyTracking.id = docRef.id;
    return docRef.set(dailyTracking);
  }
  static Future<List<DailyTracking>> getDailyTracking(String userId) async {
    var collection = getDailyTrackingCollection(userId);
    var snapshot = await collection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }



}
