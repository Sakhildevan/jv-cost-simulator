import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../config/config.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import '../utils/string_const.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.height,
    this.onFieldSubmitted,
    this.validator,
    this.textFieldInitialValue,
    this.keyboardType,
    this.inputFormat,
    //this.suffixText,
    this.suffixStyle,
    this.enabled = true,
    this.cursorheight,
    this.isError,
    this.hintText,
    this.suffix,
    this.focusNode,
    this.readOnly,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final double? height;

  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? textFieldInitialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormat;
  final bool enabled;
  final bool? readOnly;
  //final String? suffixText;
  final String? hintText;
  final bool? isError;
  final double? cursorheight;
  final TextStyle? suffixStyle;
  final Widget? suffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Timer? _debounce;

//!----------------dispose----------------
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

//!----------------_onChanged----------------
  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: kDim.kRadius10,
      ),
      child: TextFormField(
        readOnly: widget.readOnly ?? false,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        initialValue: widget.textFieldInitialValue,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormat,
        validator: widget.validator,
        onFieldSubmitted: (_) {},
        controller: widget.controller,
        onChanged: _onChanged,
        cursorWidth: 1,
        cursorHeight: widget.cursorheight ?? 20,
        decoration: InputDecoration(
          suffixIcon: widget.suffix,
          //suffixText: widget.suffixText,
          suffixStyle: widget.suffixStyle,
          errorStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 9,
              tablet: 10,
              desktop: 13,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          fillColor:
              widget.enabled ? AppColors.boxBackGround : Colors.grey.shade200,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.boxBackGround,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.isError ?? false
                  ? AppColors.red
                  : AppColors.boxBackGround,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.boxBackGround,
            ),
          ),
          isDense: true,
          hintText: widget.enabled
              ? (widget.hintText?.isNotEmpty ?? false)
                  ? widget.hintText
                  : StringConst.hintValue
              : null,
          hintStyle: KStyles()
              .reg(
                text: '',
                color: AppColors.grey,
                size: getValueForScreenType(
                  context: context,
                  mobile: 9,
                  tablet: 10,
                  desktop: 13,
                ),
                overflow: TextOverflow.visible,
              )
              .style,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        ),
        style: KStyles()
            .reg(
              text: '',
              size: getValueForScreenType(
                context: context,
                mobile: 10,
                tablet: 12,
                desktop: 14,
              ),
              color: widget.enabled ? AppColors.black : Colors.grey,
            )
            .style,
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
