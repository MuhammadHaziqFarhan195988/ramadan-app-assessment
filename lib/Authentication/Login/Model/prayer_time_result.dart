import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimeResult {
   Map<String,TimeOfDay> name = {};
 

  PrayerTimeResult.fromJson(Map<String, dynamic> json) {
   name = json.map((key, value) => MapEntry(key, TimeOfDay(
     hour: int.parse(DateFormat.Hm().parse(value).hour.toString()),
     minute: int.parse(DateFormat.Hm().parse(value).minute.toString()),
   )));

 
  }
 
}