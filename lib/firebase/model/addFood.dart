import 'package:cloud_firestore/cloud_firestore.dart';

class AddFood{
  static const String collectionName = "addFood";
  int? calories;
  int? carb;
  int? protein ;
  int? fat;
  int? water ;
  Timestamp? date;
  String? id;
  AddFood({
    this.date,

    this.carb,
    this.calories,
    this.protein,
    this.fat,
    this.water,
    this.id,
  });
  Map<String , dynamic> toFireStore() {
    return {
      "carb": carb,
      "calories": calories,
      "protein": protein,
      "water": water,
      "fat": fat,
      "date": date,
      "id":id,
    };
  }
  AddFood.fromFireStore(Map<String,dynamic>? data){
    calories = data?["calories"];
    carb=data?["carb"];
    fat = data? ["fat"];
    water = data? ["water"];
    protein = data? ["protein"];
    calories = data?["calories"];
    date = data?["date"];
    id = data? ["id"];
  }

}