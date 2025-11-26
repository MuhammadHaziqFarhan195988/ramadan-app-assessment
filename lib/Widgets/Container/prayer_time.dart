import 'package:flutter/material.dart';
import 'package:ramadan_app_assessment/const/value_const.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime(this.prayerTime,{super.key});
  final String prayerTime;

  @override
  Widget build(BuildContext context) {
    return Container(
                    // padding: EdgeInsets.all(16.0),
                    width: screenWidth(context)*0.5,
                    height: screenHeight(context)*0.04,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        width: 2.0,
                        color:  Colors.green[900]!,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(prayerTime,style: TextStyle(color: Colors.black),),
                      ],
                    ),
                  );
  }
}