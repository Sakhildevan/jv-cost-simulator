import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import 'font_styles.dart';

class KStyles {
  //*--------(light)
  Text light({
    required String text,
    Color color = AppColors.black,
    double? height,
    bool? softWrap,
    required double size,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: size,
        height: height,
        color: color,
        fontFamily: FontConst().fontFamily,
        fontWeight: FontConst().lightFont,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }

//!------------(reg)--------------
  Text reg({
    required String text,
    Color color = AppColors.black,
    double? height,
    bool? softWrap,
    double? size,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: size,
        height: height,
        color: color,
        fontFamily: FontConst().fontFamily,
        fontWeight: FontConst().regularFont,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }

//!-------------(med)-------------------
  Text med({
    required String text,
    Color color = AppColors.black,
    double? height,
    bool? softWrap,
    required double size,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: size,
        height: height,
        color: color,
        fontFamily: FontConst().fontFamily,
        fontWeight: FontConst().mediumFont,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }

//!-------------(semibold)------------
  Text semiBold({
    required String text,
    Color? color,
    double? height,
    bool? softWrap,
    required double size,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: size,
        height: height ?? 1.5,
        color: color,
        fontFamily: FontConst().fontFamily,
        fontWeight: FontConst().semiBoldFont,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }

//!-------------(bold)------------------
  Text bold({
    required String text,
    Color color = AppColors.black,
    double? height,
    bool? softWrap,
    required double size,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: size,
        height: height,
        color: color,
        fontFamily: FontConst().fontFamily,
        fontWeight: FontConst().boldFont,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }

//!-------------(black)------------------
  Text black({
    required String text,
    Color color = AppColors.black,
    double? height,
    bool? softWrap,
    required double size,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: size,
        height: height,
        color: color,
        fontFamily: FontConst().fontFamily,
        fontWeight: FontConst().blackFont,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
