import 'package:calories_coach/providers/setting_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../firebase/model/goals.dart';
import '../../style/app_color.dart';

class WaterTracker extends StatefulWidget {
  @override
  State<WaterTracker> createState() => WaterTrackerState();
}

class WaterTrackerState extends State<WaterTracker> {
  int drinkingWater = 0;

  @override
  void initState() {
    super.initState();
    loadWaterData();
  }

  void loadWaterData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final settingProvider =
      Provider.of<SettingProvider>(context, listen: false);
      int storedWater = await settingProvider.getUpdatesWater();
      setState(() {
        drinkingWater = storedWater;
      });
    });
  }

  Future<void> incrementWater(int waterGoal, SettingProvider settingProvider) async {
    if (drinkingWater < waterGoal) {
      setState(() {
        drinkingWater += 175;
        if (drinkingWater > waterGoal) {
          drinkingWater = waterGoal;
        }
      });
      await settingProvider.saveWater("updateWater", drinkingWater);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Goals>>(
      future: Goals.getGoal(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No goals found'));
        } else {
          Goals goal = snapshot.data!.first;
          final int waterGoal = goal.waterG ?? 2000;

          return SizedBox(
            height: height * 0.16,
            width: double.infinity,
            child: Card(
              color: AppColor.backgroundTextForm,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<SettingProvider>(
                  builder: (context, settingProvider, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Water",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "$drinkingWater / $waterGoal ml",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            InkWell(
                              onTap: () async {
                                await incrementWater(waterGoal, settingProvider);
                              },
                              child: ImageIcon(
                                AssetImage('assets/images/glass.png'),
                                size: 50,
                                color: AppColor.carb,
                              ),
                            )
                          ],
                        ),

                        LinearPercentIndicator(
                          backgroundColor: Colors.grey[300]!,
                          progressColor: AppColor.carb,
                          lineHeight: 20,
                          percent: (drinkingWater / waterGoal).clamp(0.0, 1.0),
                          animateFromLastPercent: true,
                          animation: true,
                          curve: Curves.easeIn,
                          barRadius: Radius.circular(10),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
