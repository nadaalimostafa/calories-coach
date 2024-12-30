import 'package:calories_coach/firebase/FireStroeHandler.dart';
import 'package:calories_coach/home_details/calories_counter/CustomCard.dart';
import 'package:calories_coach/home_details/water%20details/waterTracker.dart';
import 'package:calories_coach/ui/data/storeDataFireStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../../home_details/calories_counter/WeekCard.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // void scheduleDailyDataTask() {
    //   Workmanager().registerPeriodicTask(
    //     "dailyDataBackup",
    //     "dailyDataTask",
    //     inputData: {'userId': FirebaseAuth.instance.currentUser!.uid},
    //     frequency: const Duration(days: 1), // كل يوم
    //     initialDelay: const Duration(hours: 24), // بعد 24 ساعة
    //   );
    // }
    return FutureBuilder(
      future: FireStoreHandler.getUser(FirebaseAuth.instance.currentUser!.uid??""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // Header section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Welcome Back",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: height*0.01,),
                            Text(
                              snapshot.data?.fullName  ?? "No Name",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            StoreDataFirestore.saveDataForestore();
                          },
                          icon:ImageIcon(
                            AssetImage("assets/images/fruits_16445669.png"),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomCard(),
               WaterTracker(),
                  WeekCard(),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

