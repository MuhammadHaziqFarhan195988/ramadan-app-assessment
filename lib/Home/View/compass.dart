import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double? _heading;
  StreamSubscription<CompassEvent>? _compassSub;

  @override
  void initState() {
    super.initState();
   _compassSub = FlutterCompass.events?.listen((event) {
      setState(() {
        _heading = event.heading;
      });
    });
  }

  @override
  void dispose() {
    _compassSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Heading: ${_heading?.toStringAsFixed(2) ?? 'N/A'}°',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Rotate a compass image based on the heading
            Transform.rotate(
              angle: ((_heading ?? 0) * (math.pi / 180) * -1), // Rotate counter-clockwise
              child: Image.asset(
                'assets/images/compass_needle.png',  
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      );
 
  }
}