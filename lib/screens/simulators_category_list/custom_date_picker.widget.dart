import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/config.dart';
import '../../themes/app_colors.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.selectedDateTime,
    required this.onDayPressed,
    this.minDate,
    this.maxDate,
    this.filterMenuCtrl,
  });

  final DateTime? selectedDateTime;
  final dynamic Function(DateTime, List<Event>)? onDayPressed;
  final DateTime? minDate;
  final DateTime? maxDate;
  final MenuController? filterMenuCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: kDim.kRadius15,
        color: AppColors.cardCream,
      ),
      height: getValueForScreenType(
        context: context,
        mobile: 280,
        tablet: 280,
        desktop: 280,
      ),
      width: 300,
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(builder: (
        context,
        constraints,
      ) {
        return CalendarCarousel<Event>(
          height: constraints.maxHeight,
          childAspectRatio: getValueForScreenType(
            context: context,
            mobile: 1.3,
            tablet: 1.3,
            desktop: 1.3,
          ),
          weekDayPadding: EdgeInsets.zero,
          dayPadding: 0,
          nextDaysTextStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
          ),
          prevDaysTextStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
          ),
          todayTextStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
          ),
          daysTextStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
          ),
          headerTextStyle: TextStyle(
            color: AppColors.maroon,
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 14,
              desktop: 16,
            ),
          ),
          onDayPressed: (date, events) {
            // Check if the date is before the minDate
            if (minDate != null && date.isBefore(minDate!)) {
              return; // Ignore selection if the date is before minDate
            }
            onDayPressed?.call(
                date, events); // Call the original callback if valid

            // Close the menu after a date is selected
            filterMenuCtrl?.close();
          },
          iconColor: AppColors.maroon,
          weekdayTextStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
            color: AppColors.maroon,
          ),
          weekendTextStyle: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
            color: AppColors.maroon,
          ),
          selectedDayButtonColor: AppColors.kTextBlue,
          selectedDayTextStyle: const TextStyle(
            color: Colors.white,
          ),
          todayButtonColor: AppColors.headingTextBlue.withOpacity(0.3),
          todayBorderColor: Colors.transparent,
          selectedDateTime: selectedDateTime,
          daysHaveCircularBorder: true,
          markedDatesMap: EventList<Event>(events: {}),
          minSelectedDate: minDate,
          maxSelectedDate: maxDate,
        );
      }),
    );
  }
}
