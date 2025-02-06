import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../styles/text_styles.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';
import 'date_picker_card.widget.dart';

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({
    super.key,
    required this.startDateMenuCtrl,
    required this.endDateMenuCtrl,
  });
  final MenuController startDateMenuCtrl;
  final MenuController endDateMenuCtrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _fromDatePicker(),
        ),
        kDim.kGap05,
        KStyles().med(
          text: StringConst.to,
          size: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          ),
        ),
        kDim.kGap05,
        Expanded(
          child: _toDatePicker(),
        ),
      ],
    );
  }

  BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState> _toDatePicker() {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return DatePickerCard(
          selectedDateTime: state.selectedEndDate,
          maxDate: state.endDate,
          minDate: state.selectedStartDate, // Limit the "To" date
          crossAxisAlignment: CrossAxisAlignment.end,
          text: StringConst.to,
          dateText: fCon.formatDate(
            date: state.selectedEndDate ?? DateTime.now(),
            formatType: DateFormatType.dayMonYear,
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
        return DatePickerCard(
          minDate: state.startDate,
          maxDate: state.selectedEndDate,
          selectedDateTime: state.selectedStartDate,
          popMenuCtrl: startDateMenuCtrl,
          text: StringConst.from,
          dateText: fCon.formatDate(
            date: state.selectedStartDate ?? DateTime.now(),
            formatType: DateFormatType.dayMonYear,
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
}
