import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    required this.hintText,
    this.controller,
    required this.obscureText,
    super.key,
    this.suffixIcon,
    this.cursorHeight,
    this.validator,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final double? cursorHeight;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      cursorHeight: cursorHeight,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: true, fillColor: Colors.white,
        hintText: hintText,
        hintStyle: KStyles()
            .med(
                text: '',
                color: AppColors.grey,
                size: getValueForScreenType(
                  context: context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 14,
                ))
            .style,
        border: InputBorder.none,
        isDense: true,
        //*--------------(focused error)
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: AppColors.blue.withOpacity(0.5),
            width: 0.0,
          ),
        ),
        //*--------------(error border)
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 0.0,
          ),
        ),
        //*---------------(focused border)
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: AppColors.blue.withOpacity(0.5),
            width: 0.0,
          ),
        ),
        //*----------------(enable border)
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: AppColors.grey.withOpacity(0.2),
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
