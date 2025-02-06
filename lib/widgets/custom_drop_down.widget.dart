import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../themes/app_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.itemList,
    required this.onDropDownChanged,
    required this.dropDownValue,
    required this.dropDownHintText,
    required this.isTapped,
    required this.validator,
    required this.displayText,
    required this.value,
    this.contentPadding,
    this.fontSize,
    this.fillColor,
    this.hintColor,
  });

  final List<T>? itemList;
  final void Function(T?)? onDropDownChanged;
  final T? dropDownValue;
  final String? dropDownHintText;
  final bool? isTapped;
  final String? Function(T?)? validator;
  final String? Function(T?)? displayText;
  final String? Function(T?)? value;
  final double? fontSize;
  final Color? fillColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      dropdownStyleData: DropdownStyleData(
        elevation: 1,
        maxHeight: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: AppColors.boxBackGround,
        ),
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: WidgetStateProperty.all(6),
          thumbVisibility: WidgetStateProperty.all(true),
        ),
      ),
      alignment: Alignment.centerLeft,
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: AppColors.maroon,
          size: 20,
        ),
      ),
      validator: validator,
      decoration: InputDecoration(
        isCollapsed: true,
        errorStyle: TextStyle(
          fontSize: getValueForScreenType(
            context: context,
            mobile: 9,
            tablet: 10,
            desktop: 13,
          ),
        ),
        contentPadding: contentPadding ??
            EdgeInsets.only(
              left: -5,
              right: 5,
              top: getValueForScreenType(
                context: context,
                mobile: 6,
                tablet: 5,
                desktop: 10,
              ),
              bottom: getValueForScreenType(
                context: context,
                mobile: 6,
                tablet: 5,
                desktop: 10,
              ),
            ),
        fillColor: fillColor ?? AppColors.boxBackGround,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.boxBackGround,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.boxBackGround,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.boxBackGround,
          ),
        ),
      ),
      hint: KStyles().med(
        overflow: TextOverflow.ellipsis,
        color: hintColor ?? AppColors.grey,
        text: dropDownHintText ?? "",
        size: getValueForScreenType(
          context: context,
          mobile: 9,
          tablet: 10,
          desktop: 13,
        ),
      ),
      value: itemList?.contains(dropDownValue) == true ? dropDownValue : null,
      onChanged: onDropDownChanged,
      items: (itemList != null && itemList!.isNotEmpty)
          ? itemList!
              .where((T? item) => item != null && displayText != null)
              .map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: KStyles().med(
                  overflow: TextOverflow.visible,
                  text: displayText!(item) ?? '',
                  size: fontSize ??
                      getValueForScreenType(
                        context: context,
                        mobile: 9,
                        tablet: 10,
                        desktop: 13,
                      ),
                ),
              );
            }).toList()
          : null,
    );
  }
}
