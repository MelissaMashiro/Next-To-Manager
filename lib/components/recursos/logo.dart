import 'package:flutter/material.dart';

import '../../constants.dart';



class LogoImage extends StatelessWidget {
  LogoImage({
    this.height = 150,
    this.width = 150,
    this.fleetsSize = 18,
  });
  final double width;
  final double height;
  final double fleetsSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Image.asset(kLogoImage),
    );
  }
}
