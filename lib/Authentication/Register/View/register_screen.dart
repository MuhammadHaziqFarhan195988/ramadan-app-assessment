import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hi_way/Authentication/Register/register_controller.dart';
// import 'package:hi_way/Widget/Button/auth_button.dart';
// import 'package:hi_way/Widget/TextForm/form_field.dart';
// import 'package:hi_way/Widget/Toast/toast_message.dart';
// import 'package:hi_way/screens/login_screen.dart';
import 'package:ramadan_app_assessment/Authentication/Login/View/login_screen.dart';
import 'package:ramadan_app_assessment/Authentication/Register/Controller/register_controller.dart';
import 'package:ramadan_app_assessment/Widgets/custom_text_form.dart';
import 'package:ramadan_app_assessment/Widgets/toast_message.dart';
import 'package:ramadan_app_assessment/const/text_const.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
   static const String idScreen = "register";

    CustomTextForm userField = CustomTextForm( icon: Icons.person, hintText: "Username", isObsecure: false);
  CustomTextForm emailField = CustomTextForm( icon: Icons.email, hintText: "Email", isObsecure: false);
  CustomTextForm passwordField = CustomTextForm( icon: Icons.lock, hintText: "Password", isObsecure: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: 250,
            //   height: 250,
            // ),
        
            Text(kRegisterDisplayText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
    
                          color: Colors.white,
                        )
                        ),
            Icon(Icons.mosque, size: 100, color: Colors.white),
            SizedBox(height: 25),
            userField,
            emailField,
            passwordField,
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.amber[700]
                        ),
              child: Text("Register",style: TextStyle(color: Colors.white),), onPressed: () {

              if(userField.controller.text.length < 3){
                ToastMessage().displayToastMessage("Name must be at least 3 characters", context, type: ToastType.error);
              } else if(!emailField.controller.text.contains("@")){
                ToastMessage().displayToastMessage("Email address is not valid", context, type: ToastType.error);
              } else if(passwordField.controller.text.length < 6){
                ToastMessage().displayToastMessage("Password must be at least 6 characters", context, type: ToastType.error);
              } else {
                RegisterController().registerUser(
                  userField.controller.text.trim(),
                  emailField.controller.text.trim(),
                  passwordField.controller.text.trim(),
                  context
                );
              }
             
            },),
            SizedBox(height: 20),
            TextButton(onPressed: (){
                       Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                      }, 
                      child: Text(
                          "Already have an account? Click Here!",
                          style: TextStyle(color: Colors.white),
                          )
                        )
          ],
        ),
      ),
    );
  }
}