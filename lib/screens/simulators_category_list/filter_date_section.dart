import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../config/config.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';
import 'date_picker_text.widget.dart';

class FilterDatePickerSection extends StatelessWidget {
  const FilterDatePickerSection({
    super.key,
    required this.startDateMenuCtrl,
    required this.endDateMenuCtrl,
  });

  final MenuController startDateMenuCtrl;
  final MenuController endDateMenuCtrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //!---(Date)
        _dateTitle(context),
        //!--(space)
        const Gap(10),
        //!---(Date picker section)
        Flexible(
          child: _datePickerSection(),
        ),
        //!----(space)
        const Gap(10),
      ],
    );
  }

  Padding _datePickerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Removing Flexible if not needed
          _fromDatePicker(),
          const Gap(10),
          _toDatePicker(),
        ],
      ),
    );
  }

  BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState> _toDatePicker() {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return DatePickerTextWidget(
          selectedDateTime: state.selectedEndDate,
          maxDate: state.endDate,
          minDate: state.selectedStartDate, // Limit the "To" date
          crossAxisAlignment: CrossAxisAlignment.end,
          text: StringConst.to,
          dateText: fCon.formatDate(
            date: state.selectedEndDate ?? DateTime.now(),
            formatType: DateFormatType.dayMonthYear,
          ),
          onDayPressed: (DateTime date, List<Event> dateEvent) {
            if (state.startDate != null && date.isBefore(state.startDate!)) {
              return;
            }
            context.read<SimulatorCategoryBloc>().add(DatePickEvent(
                  date: date,
                  status: DatePickerType.end,
                ));
            endDateMenuCtrl.close();
          },
          popMenuCtrl: endDateMenuCtrl,
        );
      },
    );
  }

  BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState> _fromDatePicker() {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return DatePickerTextWidget(
          minDate: state.startDate,
          maxDate: state.selectedEndDate,
          selectedDateTime: state.selectedStartDate,
          popMenuCtrl: startDateMenuCtrl,
          text: StringConst.from,
          dateText: fCon.formatDate(
            date: state.selectedStartDate ?? DateTime.now(),
            formatType: DateFormatType.dayMonthYear,
          ),
          onDayPressed: (DateTime date, List<Event> dateEvent) {
            context.read<SimulatorCategoryBloc>().add(DatePickEvent(
                  date: date,
                  status: DatePickerType.start,
                ));
            startDateMenuCtrl.close();
          },
        );
      },
    );
  }

//!----(date title)
  Text _dateTitle(BuildContext context) {
    return KStyles().med(
      text: StringConst.date,
      size: getValueForScreenType(
        context: context,
        mobile: 12,
        tablet: 14,
        desktop: 16,
      ),
      // size: 16,
      color: AppColors.kTextBlue,
    );
  }
}
