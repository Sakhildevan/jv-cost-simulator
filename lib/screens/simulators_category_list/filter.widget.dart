import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/simulator_category/simulator_category_bloc.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../utils/string_const.dart';
import 'date_picker_section.dart';
import 'filter_status_section.dart';
import 'sell_currency_list.widget.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.datePickerMenuController,
  });

  final MenuController datePickerMenuController;

  @override
  Widget build(BuildContext context) {
    MenuController startDateMenuCtrl = MenuController();
    MenuController endDateMenuCtrl = MenuController();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: kDim.kRadius15,
        color: AppColors.cardCream,
      ),
      height: getValueForScreenType(
        context: context,
        mobile: 300,
        tablet: 300,
        desktop: 350,
      ),
      width: getValueForScreenType(
        context: context,
        mobile: 260,
        tablet: 290,
        desktop: 360,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                // Close only the date picker menu
                if (datePickerMenuController.isOpen) {
                  datePickerMenuController.close();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KStyles().reg(
                    text: StringConst.close,
                    size: 15,
                  ),
                  kDim.kGap05,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.maroon,
                      borderRadius: kDim.kRadius50,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.white,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          kDim.kGap10,
          DatePickerSection(
            startDateMenuCtrl: startDateMenuCtrl,
            endDateMenuCtrl: endDateMenuCtrl,
          ),
          kDim.kGap10,
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      //!-----(date picker section)
                      // FilterDatePickerSection(
                      //   startDateMenuCtrl: startDateMenuCtrl,
                      //   endDateMenuCtrl: endDateMenuCtrl,
                      // ),
                      //!-----(status section)
                      const Flexible(
                        child: FilterStatusSection(),
                      ),
                      getValueForScreenType(
                        context: context,
                        mobile: kDim.kGap02,
                        tablet: kDim.kGap05,
                        desktop: kDim.kGap08,
                      )
                    ],
                  ),
                ),
                //!-------(Sell currency List)
                const Expanded(
                  flex: 1,
                  child: SellCurrencyList(),
                ),
              ],
            ),
          ),
          //!-------(save button)
          getValueForScreenType(
            context: context,
            mobile: kDim.kGap02,
            tablet: kDim.kGap05,
            desktop: kDim.kGap10,
          ),
          Flexible(
            child: uiCon.globalButton(
              context: context,
              height: getValueForScreenType(
                context: context,
                mobile: 30,
                desktop: 40,
                tablet: 35,
              ),
              width: getValueForScreenType(
                context: context,
                mobile: 120,
                desktop: 180,
                tablet: 140,
              ),
              fontSize: getValueForScreenType(
                context: context,
                mobile: 12,
                desktop: 16,
                tablet: 14,
              ),
              text: StringConst.filter,
              color: AppColors.maroon,
              isIconFirst: false,
              isPng: true,
              assetImage: Assets.images.saveButton.path,
              iconHt: 17,
              iconWd: 17,
              onPressed: () {
                context.read<SimulatorCategoryBloc>().add(const FilterSave());
                if (datePickerMenuController.isOpen) {
                  datePickerMenuController.close();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
