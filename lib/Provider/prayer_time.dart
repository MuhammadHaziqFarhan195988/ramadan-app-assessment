import 'package:flutter/material.dart';
import 'package:ramadan_app_assessment/Authentication/Login/Model/prayer_time_result.dart';

class PrayerTimeProvider extends ChangeNotifier{
   Map<String, TimeOfDay> prayerTimes = {};

void init(PrayerTimeResult result){
  prayerTimes.addAll(result.name);
  notifyListeners();

}
}