import 'package:flutter/material.dart';
import '../../constants.dart';

class MyLoginField extends StatelessWidget {
  MyLoginField({
    this.keyboardType,
    @required this.hintText,
    this.icon,
    this.onChanged,
    this.obscureText = false, this.controller,
  });

  final TextInputType keyboardType;
  final String hintText;
  final IconData icon;
  final Function onChanged;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kMainColorExtraLight, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.grey),
        cursorColor: Colors.white,
        onChanged: onChanged,
        obscureText: obscureText,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: Icon(
              icon,
              color: Colors.grey[800],
            )),
      ),
    );
  }
}
