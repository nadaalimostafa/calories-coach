import 'package:calories_coach/firebase/FireStroeHandler.dart';
import 'package:calories_coach/firebase/firebase_auth_codes.dart';
import 'package:calories_coach/screens/home_screen.dart';
import 'package:calories_coach/screens/log_in_screen.dart';
import 'package:calories_coach/style/reusable_components/custom_text_filed.dart';
import 'package:calories_coach/style/reusable_components/dialog_utils.dart';
import 'package:calories_coach/style/reusable_components/validation.dart';
import 'package:calories_coach/style/reusable_components/custom_buttom_widget.dart';
import 'package:calories_coach/firebase/model/user.dart'as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'diet_Form_form.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController confirmPasswordController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> registerFormkey = GlobalKey<FormState>();





  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.06, vertical: height * 0.02),
        child: Form(
          key: registerFormkey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Text("Register ",
                      style:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 35)),
                  SizedBox(height: height*0.1,),
                  CustomTextFiled(
                    label: "Full Name",
                    keyboard:TextInputType.name,
                    controller: nameController,
                    validator:(value)=>Validation.fullNameValidator(value, "Should Enter Your Name"),
                    
                  ),

                  SizedBox(height: height*0.02,),

                  CustomTextFiled(
                    label: "ُE-mail",
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    validator:(value)=> Validation.emailValidator(value),
                  ),

                  SizedBox(height: height*0.02,),

                  CustomTextFiled(
                    label: "Passowrd",
                    keyboard: TextInputType.visiblePassword,
                    controller: passwordController,
                    isPassword: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "should enter your password";
                      }
                      if (value.length< 8){
                        return "Password should not be less than 8 character";
                      }
                    },
                  ),

                  SizedBox(height: height*0.02,),

                  CustomTextFiled(
                    label: "Confirm Passowrd",
                    keyboard: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                    isPassword: true,
                    validator: (value){
                      if(value != passwordController.text){
                        return "mismatch with password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height*0.02,),

                  CustomButtomWidget(
                    buttom: "Next",
                    onClick:createAccount
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Have An Accout?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, LogInScreen.routeName);
                          }, child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 17)
                      )),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  createAccount()async{
    if (registerFormkey .currentState!.validate()){
      try{
        DialogUtils.Showloading(context);
        // Navigator.pop(context);
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        );
        FireStoreHandler.createUser(MyUser.User(
          id: userCredential.user!.uid,
            email: emailController.text,
          fullName: nameController.text,

        ));
        Navigator.pop(context);
        Navigator.pushNamed(context, DietFormForm.routeName);
      }
      on FirebaseAuthException catch (error){
        Navigator.pop(context);
        if (error.code ==FirebaseAuthCodes.weakPassword){
          DialogUtils.ShowMessageDialog(
              context,
              'The password provided is too weak.',
              positiveButtom: "OK",
              positiveActionButtom: () {
                Navigator.pop(context);
              }
          );
        }else if (error.code == FirebaseAuthCodes.emailexist){
          DialogUtils.ShowMessageDialog(
              context,
              'The account already exists for that email.',
              positiveButtom: "OK",
              positiveActionButtom: () {
                Navigator.pop(context);
              }
          );
        }
      }
      catch(error){}

    }
  }
}
