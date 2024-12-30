import 'package:calories_coach/firebase/firebase_auth_codes.dart';
import 'package:calories_coach/screens/register_screen.dart';
import 'package:calories_coach/style/reusable_components/custom_text_filed.dart';
import 'package:calories_coach/style/reusable_components/dialog_utils.dart';
import 'package:calories_coach/style/reusable_components/validation.dart';
import 'package:calories_coach/style/reusable_components/custom_buttom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = 'Log In';

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> LogInFormkey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.02),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Welcome",
              style:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 35)),
              Text("CaloriesCoach ",
                style:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 35)),
              SizedBox(height: height*0.1,),
              Form(
                key: LogInFormkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CustomTextFiled(
                      label: "ُE-mail",
                      keyboard: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) => Validation.emailValidator(value),
                    ),
                    SizedBox(height: height * 0.02,),
                    CustomTextFiled(
                      label: "Passowrd",
                      keyboard: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "should enter your password";
                        }
                        if (value.length < 8) {
                          return "Password should not be less than 8 character";
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: height * 0.02,),

                    CustomButtomWidget(
                      buttom: "Log In",
                      onClick: logIn,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have An Accout?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            }, child: Text(
                            "Register",
                            style: TextStyle(fontSize: 17)
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logIn() async {
    if (LogInFormkey.currentState!.validate()) {
      try {
        DialogUtils.Showloading(context);
        Navigator.pop(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        // Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,(route)=>false);

      }on FirebaseAuthException catch (error) {
        // Navigator.pop(context);

        if (error.code == FirebaseAuthCodes.userNotFound) {
          DialogUtils.ShowMessageDialog(
              context,
              'No user found for that email.',
              positiveButtom: "OK",
              positiveActionButtom: () {
                Navigator.pop(context);
              }
          );
        } else if (error.code == FirebaseAuthCodes.wrongPassword) {
          DialogUtils.ShowMessageDialog(
              context,
              'Wrong Password provider  for that user ',
              positiveButtom: "OK",
              positiveActionButtom: () {
                Navigator.pop(context);
              }); //showMessage

        } //if condition
      }
    }
  }
}

