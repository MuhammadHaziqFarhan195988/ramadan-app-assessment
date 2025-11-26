import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog(this.message,{super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: double.infinity,
        // height: 50,
        // width: 200,
        decoration: BoxDecoration(
color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
          mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10.0,),
              Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.indigo),)),
              SizedBox(height: 15.0,),
              Text(message, style: TextStyle(color: Colors.black),)
            ],
          ),
        ),
      )
    );
  }
}