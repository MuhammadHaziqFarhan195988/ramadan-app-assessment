import 'package:flutter/material.dart';
import 'package:ramadan_app_assessment/Authentication/Login/Controller/login_controller.dart';
import 'package:ramadan_app_assessment/Authentication/Register/View/register_screen.dart';
import 'package:ramadan_app_assessment/Widgets/custom_text_form.dart';
import 'package:ramadan_app_assessment/Widgets/toast_message.dart';
import 'package:ramadan_app_assessment/const/text_const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 CustomTextForm emailField = CustomTextForm( icon: Icons.email, hintText: "Email", isObsecure: false);
  CustomTextForm passwordField = CustomTextForm( icon: Icons.lock, hintText: "Password", isObsecure: true);
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    emailField.controller.text = "haziqf6@gmail.com";
    passwordField.controller.text = "haziq123";
    return Scaffold(
      backgroundColor: Colors.green[900],
    
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(kLoginDisplayText, style: TextStyle(color: Colors.white, fontSize: 24.0)),
          SizedBox(height: 20.0),
          Icon(Icons.mosque, size: 100, color: Colors.white),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 4.0, left: 8.0,right:8.0),
            child: emailField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: passwordField,
          ),
          SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.amber[700]
                        ),
                        onPressed: ()  async {
                          // Handle login action
                          if(!emailField.controller.text.contains("@")){
                ToastMessage().displayToastMessage("Email address is not valid", context, type: ToastType.error);
              } else if(passwordField.controller.text.isEmpty){
                ToastMessage().displayToastMessage("Password is required", context, type: ToastType.error);
              } else {

                         isLogin = await LoginController().loginUser(
                            emailField.controller.text.trim(),
                            passwordField.controller.text.trim(),
                            context
                          );

                         
              }
                          
                        },
                        
                        child: Text("Login",style: TextStyle(color: Colors.white),),
                      ),
          SizedBox(height: 20.0),
          TextButton(onPressed: (){
                       Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.idScreen, (route) => false);
                      }, 
                      child: Text(
                          "Don't have an account? Click Here!",
                          style: TextStyle(color: Colors.white),
                          )
                        )
        ],
      )
    );
  }
}