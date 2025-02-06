import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../widgets/custom_menu_anchor.widget.dart';
import 'custom_date_picker.widget.dart';

class DatePickerTextWidget extends StatelessWidget {
  const DatePickerTextWidget({
    super.key,
    required this.text,
    required this.dateText,
    required this.onDayPressed,
    required this.popMenuCtrl,
    this.crossAxisAlignment,
    this.minDate,
    this.maxDate,
    this.selectedDateTime,
  });

  final String text;
  final String dateText;
  final MenuController popMenuCtrl;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? selectedDateTime;
  final dynamic Function(DateTime, List<Event>)? onDayPressed;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        // Text label
        KStyles().reg(
          text: text,
          size: getValueForScreenType(
            context: context,
            mobile: 8,
            tablet: 12,
            desktop: 14,
          ),
        ),

        // Date text and calendar icon
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.kTextBlue,
                  ),
                ),
              ),
              child: KStyles().bold(
                text: dateText,
                size: getValueForScreenType(
                  context: context,
                  mobile: 8,
                  tablet: 12,
                  desktop: 14,
                ),
              ),
            ),
            const Gap(5),

            // Menu Anchor for Date Picker
            CustomMenuAnchor(
              alignmentOffset: Offset(
                getValueForScreenType(
                  context: context,
                  mobile: -150,
                  tablet: -120,
                  desktop: -10,
                ),
                getValueForScreenType(
                  context: context,
                  mobile: 10,
                  tablet: 10,
                  desktop: 15,
                ),
              ),
              controller: popMenuCtrl,
              menuChildren: [
                datePicker(context),
              ],
              child: uiCon.svgIcon(
                ht: 18,
                wd: 18,
                assetImage: Assets.icons.date,
                color: AppColors.kTextBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Date Picker Widget
  Widget datePicker(BuildContext context) {
    return CustomDatePicker(
      onDayPressed: (date, events) {
        onDayPressed?.call(date, events);
        // Close the menu after a date is selected
        popMenuCtrl.close();
      },
      filterMenuCtrl: popMenuCtrl,
      selectedDateTime: selectedDateTime,
      minDate: minDate,
      maxDate: maxDate,
    );
  }
}
