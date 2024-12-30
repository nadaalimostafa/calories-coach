import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:calories_coach/firebase/model/DailyTracking.dart';
import 'package:calories_coach/food%20details/food_screen.dart';
import 'package:calories_coach/food%20details/FoodDetailsScreen.dart';
import 'package:calories_coach/screens/log_in_screen.dart';
import 'package:calories_coach/providers/setting_provider.dart';
import 'package:calories_coach/screens/register_screen.dart';
import 'package:calories_coach/screens/diet_Form_form.dart';
import 'package:calories_coach/style/app_style.dart';
import 'package:calories_coach/screens/home_screen.dart';
import 'package:calories_coach/ui/data/storeDataFireStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';



@pragma('vm:entry-point')
const taskName = "saveDataForestore";
// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//     if (taskName == 'saveDataForestore') {
//       await StoreDataFirestore.saveDataForestore();
//     }
//     return Future.value(true);
//   });
// }

// Future<void> scheduleDailyTask() async {
//   await Workmanager().registerPeriodicTask(
//     "dailyDataTask",
//     taskName,
//     frequency: Duration(minutes: 20),
//   );
// }

void callbackDispatcher() {
  AndroidAlarmManager.oneShotAt(
    DateTime.now().add(Duration(seconds: 10)),
    0,
    StoreDataFirestore.saveDataForestore,
    wakeup: true,
    exact: true,
    alarmClock: true,
  );
}

late Workmanager workmanager;
void main() async {

  WidgetsFlutterBinding .ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  //scheduleDailyTask();
  await AndroidAlarmManager.initialize();
  DateTime alarmTime = DateTime.now().add(Duration(seconds: 10));
  await AndroidAlarmManager.oneShotAt(
    alarmTime,
    0,
    StoreDataFirestore.saveDataForestore,
    wakeup: true,
    exact: true,
    alarmClock: true,
  );
  workmanager = Workmanager();

  // workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => SettingProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scheduleDailyTask();

  }
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ar"),
      ],
      locale: Locale(settingProvider.language),
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: settingProvider.themeMode,
      initialRoute: LogInScreen.routeName,
      routes: {
        LogInScreen.routeName: (_) => LogInScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        DietFormForm.routeName: (_) => DietFormForm(),
        FoodScreen.routeName: (_) => FoodScreen(),
        FoodDetailsScreen.routeName: (_) => FoodDetailsScreen(),
      },
    );

  }

}
