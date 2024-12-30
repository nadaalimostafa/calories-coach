import 'package:calories_coach/firebase/model/addFood.dart';

import 'package:calories_coach/home_details/text_form_widget.dart';
import 'package:calories_coach/screens/home_screen.dart';
import 'package:calories_coach/style/reusable_components/custom_buttom_widget.dart';
import 'package:calories_coach/style/reusable_components/user_data_widget.dart';
import 'package:calories_coach/style/reusable_components/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../firebase/FireStroeHandler.dart';
import '../firebase/model/goals.dart';
import '../style/app_color.dart';

class DietFormForm extends StatefulWidget {
  static const String routeName = 'userDetails';

  @override
  State<DietFormForm> createState() =>DietFormFormSate();
}

class DietFormFormSate extends State<DietFormForm> {
  late TextEditingController ageController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String selectedGoal = "";
  String SelectedAcitivity = "";
  String selectedGender = "";
  String selectedDiseases = "";
  List<String> goal = [
    "weight loss",
    "weight gain",
    "Maintain my current weight"
  ];
  List<String> activities = [
    "I do not do any physical activity.",
    "Light beach",
    "Medium activity",
    "Intense activity"
  ];
  List<String> water = [
    "1 ",
    "2",
    "3",
  ];
  List<String> Gender = [
    "Male ",
    "Female",
  ];

  List<String> diseases = [
    'nothing',
    "Diabetes",
    "high blood pressure"
  ];

  @override
    void initState() {
      super.initState();
      ageController = TextEditingController();
      weightController = TextEditingController();
      heightController = TextEditingController();
    }
    void dispose() {
      ageController.dispose();
      weightController.dispose();
      heightController.dispose();

      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Container(
      color: AppColor.lightSecondary,
      child: Scaffold(


          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06, vertical: height * 0.04),
                  child: Center(
                    child:Column(

                      children: [

                        Row(
                          children: [
                            IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                               icon:Icon(Icons.arrow_back_ios),
                            ),

                            SizedBox(width: width*0.2,),
                            Text("Diet Form",
                            style : Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.06*height,),
                      Form(
                        key: formkey ,
                        child: Column(
                          children: [
                            TextFormWidget(
                                  labelText: "Enter your age",
                                  keyboard: TextInputType.number,

                                  controller: ageController,
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please, Enter your age";
                                    }
                                    return null;
                                  }, ),
                        SizedBox(height: 0.03*height,),
                        TextFormWidget(
                          labelText: "Enter your height",
                          keyboard: TextInputType.number,
                          controller: heightController,
                          validation: (value) => Validation.fullNameValidator(
                              value, "Please, Enter your weight"),
                        ),
                        SizedBox(height: 0.03*height,),

                        TextFormWidget(
                          labelText: "Enter your weight",
                          keyboard: TextInputType.number,

                          controller: weightController,
                          validation: (value) => Validation.fullNameValidator(
                              value, "Please, Enter your weight"),
                        ), ],
                        ),),
                        SizedBox(height: 0.03*height,),

                        UserDataWidget(
                          dropdownValue:selectedGoal,
                          items: goal,
                          label: 'Chose your goal',
                          onSelected: (value){
                            setState(() {
                              selectedGoal = value??"";
                            });
                          },
                        ),
                        SizedBox(height: 0.03*height,),

                        UserDataWidget(
                          dropdownValue: SelectedAcitivity,
                          items: activities,
                          label: 'Choose your activity status',
                          onSelected: (value){
                            setState(() {
                              SelectedAcitivity = value??"";
                            });
                          },
                        ),
                        SizedBox(height: 0.03*height,),

                        UserDataWidget(
                          dropdownValue: selectedGender,
                          items: Gender,
                          label: 'Choose your gender',
                          onSelected: (value){
                            setState(() {
                              selectedGender= value??"";
                            });
                          },
                        ),
                        SizedBox(height: 0.03*height,),

                        UserDataWidget(
                          dropdownValue: selectedDiseases,
                          items: diseases,
                          label: 'if you have diseases',
                          onSelected: (value){
                            setState(() {
                              selectedDiseases= value??"";
                            });
                          },

                        ),

                        SizedBox(height: 0.03*height,),



                        CustomButtomWidget(buttom: "Finish",

                        onClick: calculateDiet),

                      ],
                    ),
                  )),
            ),
                   )),
    );

  }

  void calculateDiet(){
    if (formkey.currentState!.validate()) {
      if (
      selectedGoal.isNotEmpty &&
          SelectedAcitivity.isNotEmpty &&
          selectedGender.isNotEmpty &&
          selectedDiseases.isNotEmpty) {
        double bmr = 0;
        double activity = 0;
        double calories = 0;
        double caloriesGoal = 0;
        int carbG =0;
        int proteinG =0;
        int fatsG = 0;
        int waterG = 0;
        double weight = double.parse(weightController.text);
        double height = double.parse(heightController.text);
        double age = double.parse(ageController.text);
        selectedGender == "Male"
            ? bmr = 10 * weight + 6.25 * height - 5 * age + 5
            : bmr = 10 * weight + 6.25 * height - 5 * age - 161;
        if (SelectedAcitivity == "I do not do any physical activity") {activity = 1.2;}
        else if (SelectedAcitivity == "Light beach") {activity = 1.37;}
        else if (SelectedAcitivity == "Medium activity") {activity = 1.55;}
        else if (SelectedAcitivity == "Intense activity") {activity = 1.725;}
        calories = bmr * activity;
        if (selectedGoal == "weight loss") {caloriesGoal = calories - 500;}
        else if (selectedGoal == "weight gain") {caloriesGoal = calories + 500;}
        else if (selectedGoal == "Maintain my current weight") {caloriesGoal = calories;}
        carbG = ((caloriesGoal * 0.5) / 4).toInt() ;
        proteinG =( (caloriesGoal * 0.2) / 4).toInt();
        fatsG =( (caloriesGoal * 0.3) / 9).toInt();
        waterG =(weight * 35).toInt();
        Goals.createGoal( FirebaseAuth.instance.currentUser!.uid,
            Goals(
              caloriesGoal: caloriesGoal.toInt(),
              carbG: carbG,
              proteinG: proteinG,
              fatsG: fatsG,
              waterG: waterG,
            ));
        setState(() { Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        });
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        });
      } else {
        print("Please fill this fields");
      }
    }
  }


}
