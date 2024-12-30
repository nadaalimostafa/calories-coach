import 'package:calories_coach/firebase/FireStroeHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Goals {
  static const String collectionName = "goals";
  int? stepsGoal;
  int? caloriesGoal;
  int? carbG;
  int? proteinG;
  int? fatsG;
  int? waterG;
  String? id;

  Goals({
    this.stepsGoal,
    this.id,
    this.fatsG,
    this.proteinG,
    this.caloriesGoal,
    this.carbG,
    this.waterG,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "stepsGoal": stepsGoal,
      "caloriesGoal": caloriesGoal,
      "carbG": carbG,
      "proteinG": proteinG,
      "fatsG": fatsG,
      "waterG": waterG,
    };
  }

  Goals.fromFireStore(Map<String, dynamic>? data) {
    id = data?["id"];
    stepsGoal = data?["stepsGoal"] ?? 0;
    carbG = data?["carbG"] ?? 0;
    caloriesGoal = data?["caloriesGoal"] ?? 0;
    proteinG = data?["proteinG"] ?? 0;
    fatsG = data?["fatsG"] ?? 0;
    waterG = data?["waterG"] ?? 0;
  }

  static CollectionReference<Goals> getGoalCollection(String userId) {
    return FireStoreHandler.getUserCollection().doc(userId).collection(Goals.collectionName)
        .withConverter<Goals>(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return Goals.fromFireStore(data!);
      },
      toFirestore: (Goals goal, options) => goal.toFireStore(),
    );
  }

  static Future<void> createGoal(String userId, Goals goal) async {
    var collection = getGoalCollection(userId);
    var existingGoals = await collection.get();

    if (existingGoals.docs.isEmpty) {
      var docRef = collection.doc();
      goal.id = docRef.id;
      await docRef.set(goal);
    }
  }

  static Future<List<Goals>> getGoal(String userId) async {
    var collection = getGoalCollection(userId);
    var snapshot = await collection.get();

    return snapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
