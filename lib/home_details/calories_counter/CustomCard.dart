import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase/FireStroeHandler.dart';
import '../../firebase/model/addFood.dart';
import '../../firebase/model/goals.dart';
import '../../providers/setting_provider.dart';
import '../../style/app_color.dart';
import 'circularPercentWidget.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String userId = FirebaseAuth.instance.currentUser!.uid??"";
    DateTime currentTime = DateTime.now();

    return FutureBuilder<List<Goals>>(
      future: Goals.getGoal(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No goals found'));
        } else {
          Goals goal = snapshot.data!.first;

          return StreamBuilder<List<AddFood>>(
            stream: FireStoreHandler.getFoodStream(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, foodSnapshot) {
              double currentCalories = 0.0;
              double currentCarbs = 0.0;
              double currentFats = 0.0;
              double currentProtein = 0.0;

              if (foodSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (foodSnapshot.hasError) {
                return Center(child: Text("Error: ${foodSnapshot.error}"));
              }

              if (foodSnapshot.hasData && foodSnapshot.data!.isNotEmpty) {
                AddFood food = foodSnapshot.data!.first;
                currentCalories = food.calories?.toDouble() ?? 0.0;
                currentCarbs = food.carb?.toDouble() ?? 0.0;
                currentFats = food.fat?.toDouble() ?? 0.0;
                currentProtein = food.protein?.toDouble() ?? 0.0;


                currentCalories = currentCalories.clamp(0, goal.caloriesGoal?.toDouble() ?? 0.0);
                currentCarbs = currentCarbs.clamp(0, goal.carbG?.toDouble() ?? 0.0);
                currentFats = currentFats.clamp(0, goal.fatsG?.toDouble() ?? 0.0);
                currentProtein = currentProtein.clamp(0, goal.proteinG?.toDouble() ?? 0.0);

                if (currentTime.hour == 0 && currentTime.minute == 0) {
                currentCalories = 0.0;
                currentCarbs = 0.0;
                currentFats = 0.0;
                currentProtein = 0.0;
                }

                settingsProvider.saveCalories(currentCalories.toInt());
                settingsProvider.saveCarb(currentCarbs.toInt());
                settingsProvider.saveFats(currentFats.toInt());
                settingsProvider.saveProtein(currentProtein.toInt());
              }

              return SizedBox(
                height: height * 0.4,
                width: double.infinity,
                child: Card(
                  color: AppColor.backgroundTextForm,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // دائرة السعرات الحرارية
                              Row(
                                children: [
                                  SizedBox(width: width * 0.07),
                                  Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/calories.png",
                                        width: width * 0.14,
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        "${currentCalories.toInt()}",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      )
                                    ],
                                  ),
                                  SizedBox(width: width * 0.08),
                                  CircularPercentwidget(
                                    centerText:
                                    "${(currentCalories / (goal.caloriesGoal ?? 1) * 100).toStringAsFixed(0)}%",
                                    lineWidth: 5,
                                    style: Theme.of(context).textTheme.labelSmall ?? TextStyle(fontSize: 12),
                                    backgroundColor: Colors.grey[300]!,
                                    progressColor: AppColor.lightPrimaryColor,
                                    progress: (currentCalories / (goal.caloriesGoal ?? 1)).clamp(0.0, 1.0),
                                    radius: width * 0.13,
                                  ),
                                  SizedBox(width: width * 0.08),
                                  Column(
                                    children: [
                                      Text(
                                        "${goal.caloriesGoal ?? 0}",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Text(
                                        "Goal",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text("Calories"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // دائرة الكربوهيدرات
                              Column(
                                children: [
                                  CircularPercentwidget(
                                    centerText:
                                    "${currentCarbs.toInt()} / ${goal.carbG ?? 0}",
                                    lineWidth: 5,
                                    style: Theme.of(context).textTheme.labelSmall ?? TextStyle(fontSize: 12),
                                    backgroundColor: Colors.grey[300]!,
                                    progressColor: AppColor.carb,
                                    progress: (currentCarbs / (goal.carbG ?? 1)).clamp(0.0, 1.0),
                                    radius: width * 0.1,
                                  ),
                                  Text("Carbs"),
                                ],
                              ),
                              // دائرة الدهون
                              Column(
                                children: [
                                  CircularPercentwidget(
                                    centerText:
                                    "${currentFats.toInt()} / ${goal.fatsG ?? 0}",
                                    lineWidth: 5,
                                    style: Theme.of(context).textTheme.labelSmall ?? TextStyle(fontSize: 12),
                                    backgroundColor: Colors.grey[300]!,
                                    progressColor: AppColor.fat,
                                    progress: (currentFats / (goal.fatsG ?? 1)).clamp(0.0, 1.0),
                                    radius: width * 0.1,
                                  ),
                                  Text("Fats"),
                                ],
                              ),
                              // دائرة البروتين
                              Column(
                                children: [
                                  CircularPercentwidget(
                                    centerText:
                                    "${currentProtein.toInt()} / ${goal.proteinG ?? 0}",
                                    lineWidth: 5,
                                    style: Theme.of(context).textTheme.labelSmall ?? TextStyle(fontSize: 12),
                                    backgroundColor: Colors.grey[300]!,
                                    progressColor: AppColor.protein,
                                    progress: (currentProtein / (goal.proteinG ?? 1)).clamp(0.0, 1.0),
                                    radius: width * 0.1,
                                  ),
                                  Text("Protein"),
                                  SizedBox(height: height * 0.03),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
