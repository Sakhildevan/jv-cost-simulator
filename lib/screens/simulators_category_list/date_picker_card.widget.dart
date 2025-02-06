import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../widgets/custom_menu_anchor.widget.dart';
import 'custom_date_picker.widget.dart';

class DatePickerCard extends StatelessWidget {
  const DatePickerCard({
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
    return CustomMenuAnchor(
      controller: popMenuCtrl,
      menuChildren: [
        datePicker(context),
      ],
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
      child: DottedBorder(
        dashPattern: const [4, 3],
        strokeWidth: 1.3,
        color: AppColors.kTextBlue,
        strokeCap: StrokeCap.round,
        borderType: BorderType.RRect,
        radius: const Radius.circular(6),
        child: SizedBox(
          height: 30,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: AppColors.kTextBlue,
          //   ),
          //   borderRadius: kDim.kRadius05,
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              uiCon.svgIcon(
                ht: 18,
                wd: 18,
                assetImage: Assets.icons.date,
                color: AppColors.kTextBlue,
              ),
              Container(
                padding: const EdgeInsets.all(2),
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
              const SizedBox(),
            ],
          ),
        ),
      ),
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
