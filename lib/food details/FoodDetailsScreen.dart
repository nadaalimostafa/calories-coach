import 'package:calories_coach/firebase/model/addFood.dart';
import 'package:calories_coach/food%20details/TextFoodData.dart';
import 'package:calories_coach/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/FireStroeHandler.dart';
import '../firebase/model/goals.dart';
import '../style/reusable_components/custom_small_button.dart';
import 'meal.dart.dart';

class FoodDetailsScreen extends StatefulWidget {
  static const routeName = "card";

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int addedFats = 0;
  int addedCarbs = 0;
  int addedProtein = 0;
  int addedCalories = 0;

  late Meal arg;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String userId = FirebaseAuth.instance.currentUser!.uid ?? "";

    arg = ModalRoute.of(context)!.settings.arguments as Meal;

          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Stack(
                  children: [
                    // image Container
                    Container(
                      width: double.infinity,
                      height: height * 0.58,
                      child: Image.asset(
                        "assets/foodImages/${arg.imagesName}",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    // icon back
                    Positioned(
                        top: 40,
                        left: 10,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppColor.lightSecondary,
                            ))),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(arg.title, style: Theme.of(context).textTheme.labelMedium),
                SizedBox(
                  height: height * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFoodData(
                        text: "Protein(g) ", foodData: " ${arg.protein}"),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFoodData(
                      text: "Fats(g)) ",
                      foodData: "${arg.fats}",
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFoodData(
                      text: "carbohydrates(g) ",
                      foodData: " ${arg.carb}",
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFoodData(
                      text: "Calories  ",
                      foodData: "  ${arg.calories}",
                    ),
                  ],
                ),
                CustomSmallButton(
                  onPressed: () {
                    addFoodDetails();
                  },
                  text: 'Add',
                  backgroundButtonColor: AppColor.lightPrimaryColor,
                ),
              ],
            ),

    );
  }

  addFoodDetails() async {
    print(
        "Adding food: ${arg.fats}, ${arg.carb}, ${arg.protein}, ${arg.calories}");

    try {
      await FireStoreHandler.createFood(
        FirebaseAuth.instance.currentUser!.uid,
        AddFood(
          fat: arg.fats.toInt(),
          carb: arg.carb.toInt(),
          protein: arg.protein.toInt(),
          calories: arg.calories.toInt(),
        ),
      );

      setState(() {
        addedFats += arg.fats.toInt();
        addedCarbs += arg.carb.toInt();
        addedProtein += arg.protein.toInt();
        addedCalories += arg.calories.toInt();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Food added successfully!")),
      );

      Navigator.pop(context);
    } catch (e) {
      print("Error adding food: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add food!")),
      );
    }
  }
}
