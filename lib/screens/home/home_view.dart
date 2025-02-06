import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/home_bloc/home_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:johnsonville_cost_simulator/widgets/custom_table_title_view_all.widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../gen/assets.gen.dart';
import '../../routes/routes_constants.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';
import 'dashboard_widget/home_simulator_list.dart';
import 'dashboard_widget/list_summary_card.dart';

//!------------------------------------(HomeView)------------------------------------!
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CustomPopupMenuController _customPopupMenuController =
      CustomPopupMenuController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeInitial());
    });
    context.read<HomeBloc>().add(const ChangeMenu(StringConst.summary));
    Constants.width = MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        //!----(heading data)

        //*----(on show menu tap)
        onShowMenuTap(state, context);
      },
      child: Scaffold(
        body: buildBody(context),
      ),
    );
  }

//*-------(on show menu tap)
  void onShowMenuTap(HomeState state, BuildContext context) async {
    if (state.selectedOption == StringConst.newSimulator) {
      context.goNamed(RouteConstants.name.stepOne);
    } else if (state.selectedOption == StringConst.pendingSimulator) {
      context.goNamed(RouteConstants.name.simulatorCategory, queryParameters: {
        "type": fCon.simulatorCategoryStatus(
          SimulatorStatus.pending,
        )
      });
    } else if (state.selectedOption == StringConst.completedSimulator &&
        state.isMenuItemClicked) {
      context.goNamed(RouteConstants.name.simulatorCategory, queryParameters: {
        "type": fCon.simulatorCategoryStatus(
          SimulatorStatus.completed,
        )
      });
    }
    //  else if (state.selectedOption == StringConst.referenceTables &&
    //     state.isMenuItemClicked) {
    //   //todo: add reference table route
    //   "referenceTables".logInfo();
    // } else if (state.selectedOption == StringConst.myProfile &&
    //     state.isMenuItemClicked) {
    //   //todo: add my profile route
    //   "myProfile".logInfo();
    // }
    else if (state.selectedOption == StringConst.logout &&
        state.isMenuItemClicked) {
      await fCon.removeLoginCredentials();
      if (context.mounted) {
        context.goNamed(RouteConstants.name.initial);
      }
      "logout".logInfo();
    } else {}
  }

//!------------------------------------buildBody(header & inner items)------------------------------------!
  Container buildBody(
    BuildContext context,
  ) {
    return Container(
      width: Constants.width,
      height: Constants.height,
      decoration: buildBGImage(),
      child: Padding(
        padding: buildPaddingForDifferentScreenSize(context),
        child: Column(
          children: [
            //!----(header)
            buildHeader(context),
            10.height,
            //!----(inner items)
            buildInnerItemScreen(context),
          ],
        ),
      ),
    );
  }

//!------------------------------------(background image)------------------------------------!
  BoxDecoration buildBGImage() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Assets.images.loginBg.path),
        fit: BoxFit.fill,
      ),
    );
  }

//!------------------------------------(padding for different screen size)------------------------------------!
  EdgeInsets buildPaddingForDifferentScreenSize(BuildContext context) {
    return EdgeInsets.symmetric(
      vertical: getValueForScreenType(
        context: context,
        mobile: 10,
        tablet: 10,
        desktop: 10,
      ),
      horizontal: getValueForScreenType(
        context: context,
        mobile: 10,
        tablet: 40,
        desktop: 40,
      ),
    );
  }

  //!--------(itemInnerScreen)
  Widget buildInnerItemScreen(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      // If screen is mobile
      if (getValueForScreenType(
            context: context,
            mobile: 1,
            tablet: 2,
            desktop: 3,
          ) ==
          1) {
        return buildInnerItemScreenForMobile(context, state);
      } else {
        return buildInnerItemScreenForTabletDesktop(context, state);
      }
    });
  }

//*-------(inner item screen for mobile)
  Expanded buildInnerItemScreenForMobile(
      BuildContext context, HomeState state) {
    return Expanded(
      child: Container(
        decoration: buildBoxDecoration(),
        padding: EdgeInsets.symmetric(
          vertical: buildValueForVerticalScreen(context),
          horizontal: buildValueForHorizontalScreen(context),
        ),
        width: Constants.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!----(drawer)
            customFeedPopUp(context, state, _customPopupMenuController),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 5,
                ),
                child: SingleChildScrollView(
                  // Wrap Column in SingleChildScrollView
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //!----Title: summary
                      KStyles().bold(
                        text: StringConst.summary.toUpperCase(),
                        size: 18,
                        color: AppColors.kTextBlue,
                      ),

                      10.height, // Use SizedBox for spacing
                      //!--------summary card list
                      const SummaryCardList(),
                      //!--------(space)
                      20.height,
                      //!----(last created & view button method)
                      buildViewAll(context, state),
                      //!--------(simulator list)
                      SizedBox(
                        height:
                            Constants.height * 0.26, // Set height of container
                        child: const HomeSimulatorList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//*-------(inner item screen for tablet & desktop)
  Expanded buildInnerItemScreenForTabletDesktop(
      BuildContext context, HomeState state) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: buildValueForVerticalScreen(context),
            horizontal: buildValueForHorizontalScreen(context)),
        width: Constants.width,
        decoration: buildBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!----(drawer)
            customFeedPopUp(context, state, _customPopupMenuController),

            // buildDrawer(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: getValueForScreenType(
                    context: context,
                    mobile: 10,
                    tablet: 60,
                    desktop: 60,
                  ),
                  // right: 60,
                  left: getValueForScreenType(
                    context: context,
                    mobile: 5,
                    tablet: 20,
                    desktop: 20,
                  ),
                  // left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //!----Title: summary
                    KStyles().bold(
                      text: StringConst.summary.toUpperCase(),
                      size: getValueForScreenType(
                        context: context,
                        mobile: 18,
                        tablet: 23,
                        desktop: 30,
                      ),
                      color: AppColors.kTextBlue,
                    ),

                    10.height,
                    //!--------summary card list
                    const SummaryCardList(),
                    //!--(space)
                    20.height,
                    //!----(last created & view button method)
                    buildViewAll(context, state),
                    //!--------(simulator list)
                    const Expanded(child: HomeSimulatorList()),
                    // const SimulatorList()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//!-----------(last created & view button method)
  Widget buildViewAll(BuildContext context, HomeState state) {
    var headingData =
        state.costSimulatorListModel?.costSimulatorListSegmentItems;
    return CustomTableTitleViewAll(
      lastCreatedText: headingData?.title ?? "",
      onPressed: () {
        //Todo: add view all route
        context
            .goNamed(RouteConstants.name.simulatorCategory, queryParameters: {
          "type": fCon.simulatorCategoryStatus(
            SimulatorStatus.all,
          )
        });
      },
    );
  }

//!-------------------Value For Horizontal Screen----------
  double buildValueForHorizontalScreen(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 10,
      tablet: 20,
      desktop: 20,
    );
  }

//!-------------------Value For Vertical Screen----------
  double buildValueForVerticalScreen(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 10,
      tablet: 10,
      desktop: 10,
    );
  }

//!-------------------Box Decoration----------
  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: AppColors.boxBackGround,
    );
  }

  // //!--------(drawer)
  Widget customFeedPopUp(
    BuildContext context,
    HomeState state,
    CustomPopupMenuController customPopupMenuController,
  ) {
    return CustomPopupMenu(
      barrierColor: AppColors.black.withOpacity(0.7),
      showArrow: false,
      arrowColor: AppColors.white,
      arrowSize: 20,
      horizontalMargin: 50,
      position: PreferredPosition.bottom,
      menuBuilder: () =>
          buildMenuBuilder(state, context, customPopupMenuController),
      controller: customPopupMenuController,
      menuOnChange: (val) {
        context.read<HomeBloc>().add(OnMenuChanged(val));
      },
      pressType: PressType.singleClick,
      child: Icon(
        Icons.menu_rounded,
        color: AppColors.maroon,
        size: getValueForScreenType(
          context: context,
          mobile: 24,
          tablet: 30,
          desktop: 45,
        ),
      ),
    );
  }

  ClipRRect buildMenuBuilder(HomeState state, BuildContext context,
      CustomPopupMenuController customPopupMenuController) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        decoration: buildBoxDecorationForMenu(),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.popUpOption
                .map(
                  (item) => buildTextCheckPoints(
                    context,
                    state,
                    item,
                    customPopupMenuController,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecorationForMenu() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      color: AppColors.boxBackGround,
    );
  }

  Container buildTextCheckPoints(
    BuildContext context,
    HomeState state,
    String item,
    CustomPopupMenuController customPopupMenuController,
  ) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () {
          customPopupMenuController.hideMenu();
          context.read<HomeBloc>().add(ChangeMenu(item));
        },
        child: Text(
          item,
          style: TextStyle(
            fontWeight: state.selectedOption == item
                ? FontWeight.bold
                : FontWeight.w500,
            color: state.selectedOption == item
                ? AppColors.kTextBlue
                : AppColors.black,
            decorationColor: AppColors.kTextBlue,
            fontSize: 16,
            decoration: state.selectedOption == item
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

//!--------(header)

Row buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      uiCon.logo(context),
      buildUserProfileLogout(context),
    ],
  );
}

//!--------(userProfileLogout)

BlocBuilder<HomeBloc, HomeState> buildUserProfileLogout(BuildContext context) {
  return BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      return Row(
        children: [
          buildProfileImage(context),
          getValueForScreenType(
            context: context,
            mobile: 5,
            tablet: 8,
            desktop: 8,
          ).width,
          KStyles().med(
            text: (state.userName?.isNotEmpty ?? false)
                ? "Hi,  ${state.userName}"
                : "",
            color: AppColors.white,
            size: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 14,
              desktop: 14,
            ),
          ),
          getValueForScreenType(
            context: context,
            mobile: 5,
            tablet: 10,
            desktop: 10,
          ).width,
          buildDivider(),
          getValueForScreenType(
            context: context,
            mobile: 5,
            tablet: 10,
            desktop: 10,
          ).width,
          InkWell(
              onTap: () async {
                await fCon.removeLoginCredentials();
                if (context.mounted) {
                  context.goNamed(RouteConstants.name.initial);
                }
              },
              child: KStyles().reg(
                text: StringConst.logOut,
                size: getValueForScreenType(
                  context: context,
                  mobile: 10,
                  tablet: 14,
                  desktop: 14,
                ),
                color: AppColors.white,
              )),
        ],
      );
    },
  );
}

//!--------(divider)

SizedBox buildDivider() {
  return const SizedBox(
    height: 20,
    child: VerticalDivider(
      color: AppColors.grey,
      thickness: 2,
    ),
  );
}

//!--------(userProfileImage)

Center buildProfileImage(BuildContext context) {
  return Center(
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(
        Assets.images.personLogin.path,
      ),
      radius: 25,
    ),
  );
}

// //!--------(logo card)
// SizedBox buildLogo(BuildContext context) {
//   return uiCon.svgIcon(
//     assetImage: Assets.icons.logo,
//     wd: 200,
//     ht: 80,
//   );
// }

// //!--------(logo card)
// SizedBox buildLogo1(BuildContext context) {
//   return uiCon.pngImage(
//     fit: BoxFit.fitWidth,
//     assetImage: Assets.images.logo.path,
//     wd: 140,
//     ht: 70,
//   );
// }
