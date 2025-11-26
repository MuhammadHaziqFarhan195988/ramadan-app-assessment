import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
final TextEditingController controller = TextEditingController();
  final IconData icon;
  final String hintText;
  final bool isObsecure;

   CustomTextForm({super.key, required this.icon, required this.hintText, required this.isObsecure});

  @override
  Widget build(BuildContext context) {
    return Container
    (
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Colors.green[900],
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: Colors.green[900],
          ),
          focusColor: Colors.green[900],
          hintText: hintText,
        ),
      ),
    );
  }
}