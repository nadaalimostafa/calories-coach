import 'package:calories_coach/food%20details/food_screen.dart';
import 'package:calories_coach/providers/setting_provider.dart';
import 'package:calories_coach/ui/tabs/home_tab.dart';
import 'package:calories_coach/ui/tabs/profile_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase/checkAndResetData.dart';
import '../ui/tabs/steps_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String user = FirebaseAuth.instance.currentUser?.uid??"";
  // late var userData;
  //
  // Future<void> checkUserDailyData() async {
  //   try {
  //     final docSnapshot = await FirebaseFirestore.instance
  //         .collection(user) // اسم المجموعة
  //         .doc('dailyData_2024_12_10') // معرف المستند
  //         .get();
  //
  //     if (!docSnapshot.exists) {
  //       print('Document does not exist on the database');
  //     } else {
  //       setState(() {
  //         userData = docSnapshot.data(); // تحديث الحالة
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching document: $e');
  //   }
  // }

  // void fetchUserData() {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       print('Document data: ${documentSnapshot.data()}');
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   }).catchError((error) {
  //     print("Error getting document: $error");
  //   });
  // }
  @override
  void initState() {
    super.initState();
    // checkUserDailyData();
    // fetchUserData();
    // checkAndResetDailyData();
  }
  // void checkAndResetDailyData() async {
  //   await checkAndResetData(FirebaseAuth.instance.currentUser!.uid);
  // }
  int currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    StepsTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: tabs[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, FoodScreen.routeName);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            icon: const ImageIcon(
              AssetImage("assets/images/Home.png"),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            icon: Icon(Icons.directions_walk),
            label: "Steps",
          ),
          // BottomNavigationBarItem(
          //   backgroundColor: Theme.of(context).colorScheme.onTertiary,
          //   icon: const ImageIcon(
          //     AssetImage("assets/images/fitness.png"),
          //   ),
          //   label: "Workout",
          //),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            icon: const ImageIcon(
              AssetImage("assets/images/Profile.png"),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

