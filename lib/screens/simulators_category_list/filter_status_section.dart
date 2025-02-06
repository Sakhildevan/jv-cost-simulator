import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../config/config.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';

class FilterStatusSection extends StatelessWidget {
  const FilterStatusSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScrollController customScroll = ScrollController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //!---(status title)
        KStyles().med(
          text: StringConst.status,
          size: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          ),
          color: AppColors.kTextBlue,
        ),
        //!----(space)
        // getValueForScreenType(
        //   context: context,
        //   mobile: kDim.kGap02,
        //   tablet: kDim.kGap05,
        //   desktop: kDim.kGap10,
        // ),

        //!----(All)
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            controller: customScroll,
            child: ListView(
              controller: customScroll,
              children: [
                BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        uiCon.radioButton(
                          scale: getValueForScreenType(
                            context: context,
                            mobile: 0.5,
                            tablet: 0.7,
                            desktop: .8,
                          ),
                          groupValue: state.status,
                          value: SimulatorStatus.all,
                          onChanged: state.filterStatus == StringConst.all
                              ? (value) {
                                  context
                                      .read<SimulatorCategoryBloc>()
                                      .add(const FilterStatusTapEvent(
                                        status: SimulatorStatus.all,
                                      ));
                                }
                              : null,
                        ),
                        //pending text
                        KStyles().med(
                          text: 'All'.toUpperCase(),
                          size: getValueForScreenType(
                            context: context,
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ),
                          color: state.filterStatus == StringConst.all
                              ? AppColors.black
                              : AppColors.grey,
                        ),
                      ],
                    );
                  },
                ),
                //!----(pending)
                BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        uiCon.radioButton(
                          scale: getValueForScreenType(
                            context: context,
                            mobile: 0.5,
                            tablet: 0.7,
                            desktop: .8,
                          ),
                          groupValue: state.status,
                          value: SimulatorStatus.pending,
                          onChanged: state.filterStatus ==
                                      StringConst.pending.toLowerCase() ||
                                  state.filterStatus ==
                                      StringConst.all.toLowerCase()
                              ? (value) {
                                  context
                                      .read<SimulatorCategoryBloc>()
                                      .add(const FilterStatusTapEvent(
                                        status: SimulatorStatus.pending,
                                      ));
                                }
                              : null,
                        ),
                        //pending text
                        KStyles().med(
                          text: StringConst.pending.toUpperCase(),
                          size: getValueForScreenType(
                            context: context,
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ),
                          color: state.filterStatus ==
                                      StringConst.pending.toLowerCase() ||
                                  state.filterStatus ==
                                      StringConst.all.toLowerCase()
                              ? AppColors.black
                              : AppColors.grey,
                        ),
                      ],
                    );
                  },
                ), //!----(Completed)
                BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        uiCon.radioButton(
                          scale: getValueForScreenType(
                            context: context,
                            mobile: 0.5,
                            tablet: 0.7,
                            desktop: .8,
                          ),
                          groupValue: state.status,
                          value: SimulatorStatus.completed,
                          onChanged: state.filterStatus ==
                                      StringConst.completed.toLowerCase() ||
                                  state.filterStatus ==
                                      StringConst.all.toLowerCase()
                              ? (value) {
                                  context.read<SimulatorCategoryBloc>().add(
                                        const FilterStatusTapEvent(
                                          status: SimulatorStatus.completed,
                                        ),
                                      );
                                }
                              : null,
                        ),
                        //completed text
                        KStyles().med(
                          text: StringConst.completed.toUpperCase(),
                          size: getValueForScreenType(
                            context: context,
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ),
                          color: state.filterStatus ==
                                      StringConst.completed.toLowerCase() ||
                                  state.filterStatus ==
                                      StringConst.all.toLowerCase()
                              ? AppColors.black
                              : AppColors.grey,
                        ),
                      ],
                    );
                  },
                ),
                // //!----(approval)
                BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        uiCon.radioButton(
                          scale: getValueForScreenType(
                            context: context,
                            mobile: 0.5,
                            tablet: 0.7,
                            desktop: .8,
                          ),
                          groupValue: state.status,
                          value: SimulatorStatus.approval,
                          onChanged: state.filterStatus ==
                                      StringConst.approval.toLowerCase() ||
                                  state.filterStatus ==
                                      StringConst.all.toLowerCase()
                              ? (value) {
                                  context
                                      .read<SimulatorCategoryBloc>()
                                      .add(const FilterStatusTapEvent(
                                        status: SimulatorStatus.approval,
                                      ));
                                }
                              : null,
                        ),
                        //pending text
                        KStyles().med(
                          text: "Approval".toUpperCase(),
                          size: getValueForScreenType(
                            context: context,
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ),
                          color: state.filterStatus ==
                                      StringConst.approval.toLowerCase() ||
                                  state.filterStatus ==
                                      StringConst.all.toLowerCase()
                              ? AppColors.black
                              : AppColors.grey,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
