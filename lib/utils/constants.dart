import 'package:flutter/material.dart';

class Constants {
  static double width = 0;
  static double height = 0;
}

class ColorConst {
  static BoxShadow completeBoxShadow = BoxShadow(
    color: Colors.black54.withOpacity(0.5),
    spreadRadius: 0.2,
    blurRadius: 3,
    offset: const Offset(0, 3),
  );
}

//!-------------(fl charts curve and animation)
Curve flCurve = Curves.fastOutSlowIn;
Duration flDuration = const Duration(milliseconds: 550);
