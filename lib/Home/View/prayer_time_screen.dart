import 'package:flutter/material.dart';
import 'package:ramadan_app_assessment/Widgets/clock.dart';
import 'package:ramadan_app_assessment/const/value_const.dart';
import 'package:ramadan_app_assessment/Provider/prayer_time.dart';
import 'package:ramadan_app_assessment/Widgets/Container/prayer_time.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class PrayerTimeScreen extends StatefulWidget {
    PrayerTimeScreen({super.key,this.userName,});
  String? userName;

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
         
 
          children: [
            SizedBox(height: 45.0),
            Text('Welcome, ${widget.userName}!'),
            Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90.0),
                border: Border.all(
                  width: 2.0,
                  color:  Colors.green[900]!,
                ),
              ),
              child: Center(child: Clock()),
            ),
            Container(
              width: screenWidth(context)*0.7,
              height: screenHeight(context)*0.5,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 2.0,
                  color:  Colors.green[900]!,
                ),
              ),
              child: Consumer<PrayerTimeProvider>(
                builder: (context,data,child) {
                  return Column(
                    children: [
                      SizedBox(height: 20.0),
                      Text("Prayer Times", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.0),
                      PrayerTime("Fajr: ${data.prayerTimes['Fajr']!.hour.toString().padLeft(2, '0')} : ${data.prayerTimes['Fajr']!.minute.toString().padLeft(2, '0')}"),
                      SizedBox(height: 10.0),
                      PrayerTime("Sunrise: ${data.prayerTimes['Sunrise']!.hour.toString().padLeft(2, '0')} : ${data.prayerTimes['Sunrise']!.minute.toString().padLeft(2, '0')}"),
                      SizedBox(height: 10.0),
                      PrayerTime("Dhuhr: ${data.prayerTimes['Dhuhr']!.hour.toString().padLeft(2, '0')} : ${data.prayerTimes['Dhuhr']!.minute.toString().padLeft(2, '0')}"),
                      SizedBox(height: 10.0),
                      PrayerTime("Asr: ${data.prayerTimes['Asr']!.hour.toString().padLeft(2, '0')} : ${data.prayerTimes['Asr']!.minute.toString().padLeft(2, '0')}"),
                      SizedBox(height: 10.0),
                      PrayerTime("Maghrib: ${data.prayerTimes['Maghrib']!.hour.toString().padLeft(2, '0')} : ${data.prayerTimes['Maghrib']!.minute.toString().padLeft(2, '0')}"),
                      SizedBox(height: 10.0),
                      PrayerTime("Isha: ${data.prayerTimes['Isha']!.hour.toString().padLeft(2, '0')} : ${data.prayerTimes['Isha']!.minute.toString().padLeft(2, '0')}"),
                      
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      );
  }
}