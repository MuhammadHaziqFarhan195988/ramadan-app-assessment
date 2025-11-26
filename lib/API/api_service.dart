import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
 import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ramadan_app_assessment/Authentication/Login/Model/prayer_time_result.dart';
import 'package:ramadan_app_assessment/Provider/prayer_time.dart';
 

class ApiService {

final String apiUrl = "https://api.aladhan.com/v1/timingsByCity/26-11-2025?city=Dengkil&country=Malaysia&state=Selangor&method=17&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&school=0&timezonestring=UTC&calendarMethod=UAQ";


Future<String> fetchData(BuildContext context, {String? locality,String? state,String? country,}) async {
  
  
  
  DateTime date = DateTime.now();
Position? position = await _getCurrentLocation();
Placemark? placemark =await getAddressFromLatLng(position!.latitude, position.longitude);
PrayerTimeResult prayerTimeResult;
  final response = await http.get(Uri.parse("https://api.aladhan.com/v1/timingsByCity/$date?city=${locality??placemark!.locality}&country=${country??placemark!.country}&state=${state??placemark!.administrativeArea}&method=17&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&school=0&timezonestring=UTC&calendarMethod=UAQ"));
if(context.mounted){ Navigator.of(context).pop();}
  if (response.statusCode != 200) {
    throw Exception('Failed to load data from API');
  } else {
      
    var decodeData = jsonDecode(response.body);
    print("decoded body is $decodeData");
   prayerTimeResult =   PrayerTimeResult.fromJson(decodeData['data']['timings']);
   Provider.of<PrayerTimeProvider>(context, listen: false).init(prayerTimeResult);
    return response.body;
  }
}

   

    Future<Position?> _getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, handle this case (e.g., show a dialog)
        return Future.error('Location services are disabled.');
      }

      // Check location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle this case
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied, handle this case
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }

      // Get the current position
      return await Geolocator.getCurrentPosition(locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ));
    }

    Future<Placemark?> getAddressFromLatLng(double latitude, double longitude) async {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          print('Address: ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}');
          return place;
        } else {
          print('No address available for the provided coordinates.');
        }
      } catch (e) {
        print('Error occurred while fetching address: $e');
      }
    }

/* curl -X GET "https://api.aladhan.com/v1/timingsByCity/26-11-2025?city=Dengkil&country=Malaysia&state=Selangor&method=17&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&school=0&timezonestring=UTC&calendarMethod=UAQ" \
 -H 'accept: application/json'  */
}