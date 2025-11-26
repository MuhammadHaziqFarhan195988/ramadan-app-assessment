
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ramadan_app_assessment/API/api_service.dart';
import 'package:ramadan_app_assessment/Authentication/Login/View/login_screen.dart';
import 'package:ramadan_app_assessment/Authentication/Login/Model/prayer_time_result.dart';

import 'package:ramadan_app_assessment/Widgets/Dialog/Status/loading_dialog.dart';
import 'package:ramadan_app_assessment/Widgets/toast_message.dart';
import 'package:ramadan_app_assessment/const/text_const.dart';
import 'package:ramadan_app_assessment/main.dart';
import 'package:ramadan_app_assessment/Home/View/home_screen.dart';
 


class LoginController {

  Future<bool> loginUser(
    String email, 
    String password, 
    context,
    ) async {
      bool status = false;
       showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => LoadingDialog(kLoadingMessage),
                          );
      FirebaseAuth auth = FirebaseAuth.instance;
 auth.signInWithEmailAndPassword(
           email: email,
           password: password)
       .then((auth) {

        if (auth.user != null) {
      // User is signed in
     

    usersRef
       .child(auth.user!.uid).once().then((DatabaseEvent event) async {
         if (event.snapshot.value != null) {
         
          
           String? responseData;
            responseData = await ApiService().fetchData(context);
            ToastMessage().displayToastMessage("Login Successful.", context, type: ToastType.success);
           Navigator.of(context).pop();
            
       
           Navigator.pushNamedAndRemoveUntil(
         context, HomeScreen.idScreen, (route) => false,
         arguments: event.snapshot.value
         );
    
      print("User is signed in ${event.snapshot.value}!");
      status = true;
      
         } else {
           ToastMessage().displayToastMessage("No record exists for this user. Please create a new account.", context, type: ToastType.error);
           auth.user!.delete();
           FirebaseAuth.instance.signOut();
           Navigator.of(context).pop();
           
         }} );

       
    } else {
      // No user is signed in
      Navigator.of(context).pop();
      print("No user is signed in.");
      
    }
     // Create a new user in the database

 
    
   }).catchError((errMsg) {
     // Handle errors
      ToastMessage().displayToastMessage("Error: ${errMsg.toString()}", context, type: ToastType.error);
      Navigator.of(context).pop();
      
   });


  return status;
  }

  Future<void> logoutUser(context) async {
    await FirebaseAuth.instance.signOut();
    ToastMessage().displayToastMessage("User Has Been Logged Out Successfully.", context, type: ToastType.success);
    Navigator.pushNamedAndRemoveUntil(
      context, 
      LoginScreen.idScreen, 
      (route) => false
    );
  }
}