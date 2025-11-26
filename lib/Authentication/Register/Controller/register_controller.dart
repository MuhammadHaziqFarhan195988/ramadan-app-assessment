import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ramadan_app_assessment/Widgets/toast_message.dart';
import 'package:ramadan_app_assessment/main.dart';
import 'package:ramadan_app_assessment/Home/View/home_screen.dart';


class RegisterController {

 void registerUser(
    String name, 
    String email, 
    String password, 
   
    context,
    ) async {
      FirebaseAuth auth = FirebaseAuth.instance;
 auth.createUserWithEmailAndPassword(
           email: email,
           password: password)
       .then((auth) {

        if (auth.user != null) {
      // User is signed in
           Map userDataMap = {
       "name": name,
       "email": email,
     
     };

    usersRef
       .child(auth.user!.uid)
       .set(userDataMap);

     ToastMessage().displayToastMessage("Congratulations, your account has been created.", context, type: ToastType.success);

       Navigator.pushNamedAndRemoveUntil(
         context, HomeScreen.idScreen, (route) => false);
      print("User is signed in!");
    } else {
      // No user is signed in
      print("No user is signed in.");
    }
     // Create a new user in the database

 
    
   }).catchError((errMsg) {
     // Handle errors
      ToastMessage().displayToastMessage("Error: ${errMsg.toString()}", context, type: ToastType.error);
   });



  }
}