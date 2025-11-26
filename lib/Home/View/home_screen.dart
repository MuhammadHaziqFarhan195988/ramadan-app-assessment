import 'package:flutter/material.dart';

import 'package:ramadan_app_assessment/API/api_service.dart';
 
import 'package:ramadan_app_assessment/Authentication/Login/Controller/login_controller.dart';
import 'package:ramadan_app_assessment/Home/View/compass.dart';
import 'package:ramadan_app_assessment/Home/View/prayer_time_screen.dart';

import 'package:ramadan_app_assessment/Widgets/Dialog/Status/loading_dialog.dart';
 
 
import 'package:ramadan_app_assessment/const/text_const.dart';
 
 
 

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
    HomeScreen({super.key, this.userName, this.responseData});
  String? userName;
  String? responseData;
  static const String idScreen = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
final controllerState = TextEditingController();
final controllerCountry = TextEditingController();
final controllerCity = TextEditingController();
  

int _selectedIndex = 0;

List<Widget> _widgetOptions = <Widget>[
    PrayerTimeScreen(),
    Compass(),
 
  ];

 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Home Screen',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: () {
              // Handle logout action
              LoginController().logoutUser(context);
            },
          ),
        ],
      ),
      body:_widgetOptions.elementAt(_selectedIndex),  
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text("Input City/State/Country"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controllerCity,
                  decoration: InputDecoration(
                    labelText: "City",
                  ),
                ),
                TextField(
                  controller: controllerState,
                  decoration: InputDecoration(
                    labelText: "State",
                  ),
                ),
                TextField(
                  controller: controllerCountry,
                  decoration: InputDecoration(
                    labelText: "Country",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: Text("Cancel")
              ),
              TextButton(
                onPressed: () async{
                  showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => LoadingDialog(kLoadingMessage),
                          );
                      await ApiService().fetchData(context, locality: controllerCity.text,state: controllerState.text,country: controllerCountry.text);     
                      Navigator.of(context).pop();
                  setState(() {
                  
                  });
                  
                  
                }, 
                child: Text("Confirm")
              )
            ],
          );
        });
      },
        child: Icon(Icons.edit)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mosque),
            label: 'Prayer Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: 'Compass',
          ),
          
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}