import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../utils/string_const.dart';

class FontConst {
  FontWeight lightFont = FontWeight.w300;
  FontWeight regularFont = FontWeight.w400;
  FontWeight mediumFont = FontWeight.w500;
  FontWeight semiBoldFont = FontWeight.w600;
  FontWeight boldFont = FontWeight.w700;
  FontWeight blackFont = FontWeight.w800;
  String fontFamily = StringConst.tabletGothic;
  double boxTitleFontSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 14,
      tablet: 16,
      desktop: 20,
    );
  }

  double boxLabelFontSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 11,
      tablet: 13,
      desktop: 15,
    );
  }

  double boxsubFontSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 10,
      tablet: 12,
      desktop: 14,
    );
  }
}
