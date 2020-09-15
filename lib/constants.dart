import 'package:flutter/material.dart';

const String kLogoImage = 'assets/images/logo.png';
const kPrimaryBarColor = Color(0xFF181C28);
const kMainColor = Color(0xFFffd180);
const kMainColorLight = Color(0xFFffffb1);
const kMainColorDark = Color(0xFFcaa052);
const kMainColorExtraLight = Color(0xFFFFFFDC);

const kBrownTextStyle = TextStyle(fontSize: 15, color: kMainColorDark);

const kBoxDecorationLogin = BoxDecoration(
  boxShadow: [
    BoxShadow(color: Colors.black, blurRadius: 15, offset: Offset(0, 4))
  ],
  color: kMainColorLight,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(35),
    topRight: Radius.circular(35),
  ),
);

//decoracion del contendor de los inputs
final kBoxFormDecoration = BoxDecoration(
    color: kMainColorLight, borderRadius: BorderRadius.circular(10));

const List kTorres = ['A', 'B', 'C', 'D'];

const List kNumeroTorres = ['105', '201', '305', '210'];
