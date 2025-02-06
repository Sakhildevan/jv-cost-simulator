import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/home_bloc/home_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../routes/routes_constants.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/string_const.dart';
import '../../widgets/background_screen.dart';
import '../../widgets/custom_arrow.widget.dart';
import '../../widgets/custom_menu_anchor.widget.dart';
import '../../widgets/page_indicator.widget.dart';
import '../../widgets/pop_menu.widget.dart';
import 'custom_row_widget.dart';
import 'custom_search_bar.widget.dart';
import 'filter.widget.dart';
import 'pending_list_table.widget.dart';

class SimulatorCategoryView extends StatelessWidget {
  const SimulatorCategoryView({
    super.key,
    required this.simulatorType,
  });
  final String simulatorType;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchCtrl = TextEditingController();
    CustomPopupMenuController popMenuCtrl = CustomPopupMenuController();
    // CustomPopupMenuController filterMenuCtrl = CustomPopupMenuController();
    MenuController filterMenuCtrl = MenuController();
    if (simulatorType == StringConst.pending) {
      context
          .read<HomeBloc>()
          .add(const ChangeMenu(StringConst.pendingSimulator));
    } else if (simulatorType == StringConst.completed) {
      context
          .read<HomeBloc>()
          .add(const ChangeMenu(StringConst.completedSimulator));
    }
    context
        .read<SimulatorCategoryBloc>()
        .add(SimCategoryInit(type: simulatorType));

    return Scaffold(
      body: _body(
        popMenuCtrl,
        context,
        filterMenuCtrl,
        searchCtrl,
      ),
    );
  }

  BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState> _body(
    CustomPopupMenuController popMenuCtrl,
    BuildContext context,
    MenuController filterMenuCtrl,
    TextEditingController searchCtrl,
  ) {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return BackgroundScreen(
          userName: state.userName,
          button: _bottomButtons(context),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType(
                context: context,
                mobile: 14,
                tablet: 18,
                desktop: 20,
              ),
              vertical: 8,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //!-----Drawer
                      PopMenu(
                        popMenuCtrl: popMenuCtrl,
                      ),
                      //!-----space
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //!----Title: Pending Simulator
                            _buildTitle(context),
                            //!----(space)---
                            // const Gap(20),
                            _buildFilterAndSearchSection(
                                filterMenuCtrl, searchCtrl),
                            //!-subHead
                            //buildSubHead(context),
                            //!--(space)
                            const Gap(20),
                            //!----(pending list table)
                            const Expanded(
                              child: PendingListTable(),
                            ),
                            //!----(space)---
                            const Gap(10),
                            //!----(page indicator)
                            _buildPageIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>
      _buildPageIndicator() {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return PageIndicator(
          totalPage: state.totalPages ?? 0,
          currentIndex: state.currentPageIndex ?? 0,
          onTap: (int? index) {
            context
                .read<SimulatorCategoryBloc>()
                .add(PageChangeEvent(index: index ?? 0));
          },
        );
      },
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _backButton(context),
      ],
    );
  }

  Widget _backButton(BuildContext context) {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return uiCon.globalButton(
          context: context,
          iconHt: 25,
          iconWd: 25,
          isIconFirst: true,
          isPng: true,
          text: StringConst.back,
          assetImage: Assets.images.back.path,
          height: getValueForScreenType(
            context: context,
            mobile: 30,
            desktop: 40,
            tablet: 35,
          ),
          width: getValueForScreenType(
            context: context,
            mobile: 120,
            desktop: 200,
            tablet: 140,
          ),
          onPressed: () {
            context.goNamed(
              RouteConstants.name.home,
            );
          },
        );
      },
    );
  }

  BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>
      _buildFilterAndSearchSection(
    MenuController filterMenuCtrl,
    TextEditingController searchCtrl,
  ) {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (state.showSearch ?? false)
                ? CustomSearchBar(
                    onClear: () {
                      context
                          .read<SimulatorCategoryBloc>()
                          .add(const SearchEvent(query: ''));
                      searchCtrl.clear();
                    },
                    onSearchTap: (String query) {
                      context
                          .read<SimulatorCategoryBloc>()
                          .add(SearchEvent(query: query));
                    },
                    onCloseTap: () {
                      context
                          .read<SimulatorCategoryBloc>()
                          .add(const SearchEvent(query: ''));
                      context
                          .read<SimulatorCategoryBloc>()
                          .add(const ShowOrHideSearch(showSearch: false));
                      searchCtrl.clear();
                    },
                    searchCtrl: searchCtrl,
                    onChanged: (String value) {
                      if (value.isEmpty) {
                        context
                            .read<SimulatorCategoryBloc>()
                            .add(const SearchEvent(query: ''));
                      }
                    },
                  )
                :
                //!--(filter button)
                Row(
                    children: [
                      _filterSection(context, filterMenuCtrl),

                      const Gap(20),
                      //!--(search button)
                      InkWell(
                        onTap: () {
                          context
                              .read<SimulatorCategoryBloc>()
                              .add(const ShowOrHideSearch(showSearch: true));
                        },
                        child: CustomRow(
                          text: StringConst.searchBy,
                          asset: Assets.icons.search,
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }

  CustomMenuAnchor _filterSection(
      BuildContext context, MenuController filterMenuCtrl) {
    return CustomMenuAnchor(
      alignmentOffset: Offset(
        getValueForScreenType(
          context: context,
          mobile: -100,
          tablet: -52,
          desktop: -126,
        ),
        0,
      ),
      controller: filterMenuCtrl,
      menuChildren: [
        const Center(
          child: CustomArrow(
            quarterTurns: 0,
            color: AppColors.cardCream,
            arrowSize: 20,
          ),
        ),
        FilterWidget(
          datePickerMenuController: filterMenuCtrl,
        )
      ],
      child: CustomRow(
        text: StringConst.filterBy,
        asset: Assets.icons.filter,
      ),
    );
  }

  double buildValueForHorizontalScreen(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 10,
      tablet: 20,
      desktop: 20,
    );
  }

  double buildValueForVerticalScreen(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 10,
      tablet: 10,
      desktop: 10,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
      builder: (context, state) {
        return KStyles().bold(
          text: state.costSimulatorListModel?.costSimulatorListSegmentItems
                  ?.title ??
              '',
          color: AppColors.kTextBlue,
          size: getValueForScreenType(
            context: context,
            mobile: 18,
            tablet: 23,
            desktop: 30,
          ),
        );
      },
    );
  }
}

Padding buildSubHead(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(
      getValueForScreenType(
        context: context,
        mobile: 0,
        tablet: 6,
        desktop: 8,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCreatedText(context),
      ],
    ),
  );
}

BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState> buildCreatedText(
  BuildContext context,
) {
  return BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
    builder: (context, state) {
      return Text(
        state.costSimulatorListModel?.costSimulatorListSegmentItems?.subtitle ??
            '',
        style: TextStyle(
          fontSize: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          ),
          fontWeight: FontWeight.bold,
          color: AppColors.kTextBlue,
        ),
      );
    },
  );
}

TextButton buildViewAllButton(BuildContext context) {
  return TextButton(
    onPressed: () {},
    child: Text(
      StringConst.viewAll,
      style: TextStyle(
          fontSize: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          ),
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline),
    ),
  );
}
