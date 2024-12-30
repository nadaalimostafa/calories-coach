import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../firebase/model/GetResult.dart';
import '../../home_details/calories_counter/circularPercentWidget.dart';
import '../../style/app_color.dart';
import '../../style/reusable_components/custom_small_button.dart';

class StepsTab extends StatefulWidget {
  @override
  StepsTabState createState() => StepsTabState();
}

class StepsTabState extends State<StepsTab> {
  late Stream<StepCount> _stepCountStream;
  int stepsTracking = 0;
  Timer? timer;
  double goal = 1000;

  @override
  void initState() {
    super.initState();
    initializePedometer();
    requestPermission();
    loadGoal();
  }

  Future<void> requestPermission() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      await Permission.activityRecognition.request();
    }
  }

  void initializePedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount count) {
    setState(() {
      stepsTracking = count.steps;
    });
    GetResult.updateSteps(count.steps);
  }

  void onStepCountError(error) {
    setState(() {
      stepsTracking = 0;
    });
  }


  Future<void> loadGoal() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString("userId") != userId) {
      await prefs.setDouble('stepsGoal', 1000);
      await prefs.setString('userId', userId!);
    }

    setState(() {
      goal = prefs.getDouble('stepsGoal') ?? 1000;
    });
  }

  Future<void> saveGoal(double newGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('stepsGoal', newGoal);
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await prefs.setString('userId', userId!);
  }

  Future<void> saveSteps(int steps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("stepsCount", steps);
  }

  @override
  void dispose() {
    //timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = stepsTracking / goal.toInt();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Set your daily step goal: ${goal.toInt()} steps"),
            Slider(
              value: goal,
              min: 1000,
              max: 20000,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  goal = value;
                });
              },
            ),
            SizedBox(height: height * 0.03),
            CustomSmallButton(
              onPressed: () {
                saveGoal(goal);
                print("Goal set to: $goal steps");
              },
              text: "Set Goal",
              backgroundButtonColor: AppColor.lightPrimaryColor,
            ),
            SizedBox(height: height * 0.04),
            CircularPercentwidget(
              backgroundColor: Colors.grey[300]!,
              progressColor: AppColor.lightPrimaryColor,
              progress: progress,
              radius: width * 0.45,
              style: TextStyle(fontSize: 18, color: Colors.grey),
              lineWidth: 15,
              icon: Icons.directions_walk,
              centerText: "${(progress * 100).toStringAsFixed(1)}%",
              iconSize: width * 0.1,
            ),
            SizedBox(height: height * 0.04),
            Text(
              "Total Steps: $stepsTracking",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 18),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Daily Goal: ${goal.toInt()} Steps",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
