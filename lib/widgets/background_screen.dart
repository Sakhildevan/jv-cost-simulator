import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/home_bloc/home_bloc.dart';
import 'package:johnsonville_cost_simulator/themes/app_colors.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../config/config.dart';
import '../gen/assets.gen.dart';
import '../routes/routes_constants.dart';
import '../utils/constants.dart';
import '../utils/enums.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({
    required this.child,
    super.key,
    this.button,
    this.userName,
  });
  final Widget? child;
  final Widget? button;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        //*----(on show menu tap)
        onShowMenuTap(state, context);
      },
      child: Container(
        width: Constants.width,
        height: Constants.height,
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 8,
            tablet: 18,
            desktop: 60,
          ),
          vertical: 10,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.loginBg.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            uiCon.pageHeader(userName: userName ?? ''),
            kDim.kGap10,
            _mainContentBox(context),
            kDim.kGap10,
            button ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _mainContentBox(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 5,
            tablet: 5,
            desktop: 5,
          ),
          vertical: 8,
        ),
        width: Constants.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.boxBackGround,
        ),
        child: child,
      ),
    );
  }
}

//*-------(on show menu tap)
void onShowMenuTap(HomeState state, BuildContext context) async {
  if (state.selectedOption == StringConst.newSimulator &&
      state.isMenuItemClicked) {
    context.goNamed(RouteConstants.name.stepOne);
  } else if (state.selectedOption == StringConst.pendingSimulator &&
      state.isMenuItemClicked) {
    context.goNamed(RouteConstants.name.simulatorCategory, queryParameters: {
      "type": fCon.simulatorCategoryStatus(
        SimulatorStatus.pending,
      )
    });
    //todo: add pending simulator route
  } else if (state.selectedOption == StringConst.summary &&
      state.isMenuItemClicked) {
    context.goNamed(RouteConstants.name.home);
  } else if (state.selectedOption == StringConst.completedSimulator &&
      state.isMenuItemClicked) {
    context.goNamed(RouteConstants.name.simulatorCategory, queryParameters: {
      "type": fCon.simulatorCategoryStatus(
        SimulatorStatus.completed,
      )
    });
  }
  // else if (state.selectedOption == StringConst.referenceTables &&
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
