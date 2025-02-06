import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/routes/routes_constants.dart';
import 'package:johnsonville_cost_simulator/screens/login/login_view.dart';
import 'package:johnsonville_cost_simulator/screens/step_one/step_one_view.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';

import '../screens/home/home_view.dart';
import '../screens/pricing/pricing_screen.dart';
import '../screens/simulators_category_list/simulator_category_view.dart';
import '../screens/step_two/step_two_view.dart';

class MyRouter {
  /// The route configuration.
  static final GlobalKey<NavigatorState> _rootNavKey =
      GlobalKey<NavigatorState>();
  static final router = GoRouter(
    redirect: (context, state) async {
      final isLoggedIn =
          await fCon.getValueFromStorage(value: StringConst.isLoggedIn);
      if (isLoggedIn != "true") {
        return RouteConstants.path.login;
      } else if (isLoggedIn == 'true' &&
          state.fullPath == RouteConstants.path.login) {
        return RouteConstants.path.home;
      } else {
        return null;
      }
    },
    navigatorKey: _rootNavKey,
    initialLocation: RouteConstants.path.initial,
    debugLogDiagnostics: true,
    routes: [
      //*----(Initial view)
      GoRoute(
        path: RouteConstants.path.initial,
        name: RouteConstants.name.initial,
        builder: (context, state) => const LoginView(),
      ),
      //*----(Login view)
      GoRoute(
        path: RouteConstants.path.login,
        name: RouteConstants.name.login,
        builder: (context, state) => const LoginView(),
      ),
      //*-----(Home view)
      GoRoute(
        redirect: (context, state) async {
          //login checker
          return await loginChecker();
        },
        path: RouteConstants.path.home,
        name: RouteConstants.name.home,
        builder: (context, state) => const HomeView(),
      ),
      //*-----(Step One view)
      GoRoute(
        redirect: (context, state) async {
          //login checker
          return await loginChecker();
        },
        path: RouteConstants.path.stepOne,
        name: RouteConstants.name.stepOne,
        builder: (context, state) => StepOneView(
          simulatorId: state.uri.queryParameters["id"] ?? "",
        ),
      ),
      //*-----(Step two view)
      GoRoute(
        redirect: (context, state) async {
          //login checker
          return await loginChecker();
        },
        path: RouteConstants.path.stepTwo,
        name: RouteConstants.name.stepTwo,
        builder: (context, state) {
          return StepTwoView(
            simulatorId: state.uri.queryParameters["id"] ?? "",
          );
        },
      ),
      //*-----(Pricing view)
      GoRoute(
        redirect: (context, state) async {
          //login checker
          return await loginChecker();
        },
        path: RouteConstants.path.pricing,
        name: RouteConstants.name.pricing,
        builder: (context, state) => PricingScreen(
          simulatorId: state.uri.queryParameters["id"] ?? "",
          packUOM: state.uri.queryParameters["packUOM"] ?? "",
          sellPriceUOM: state.uri.queryParameters["sellPriceUOM"] ?? "",
        ),
      ),
      //TODO : need to change this
      // //*-----(Pricing view)
      // GoRoute(
      //   redirect: (context, state) async {
      //     //login checker
      //     return await loginChecker();
      //   },
      //   path: RouteConstants.path.pricing,
      //   name: RouteConstants.name.pricing,
      //   builder: (context, state) => PricingView(
      //     simulatorId: state.uri.queryParameters["id"] ?? "",
      //   ),
      // ),
      //*-----(Pending simulator view)
      GoRoute(
        redirect: (context, state) async {
          //login checker
          return await loginChecker();
        },
        path: RouteConstants.path.simulatorCategory,
        name: RouteConstants.name.simulatorCategory,
        builder: (context, state) {
          return SimulatorCategoryView(
            simulatorType: state.uri.queryParameters["type"] ?? "",
          );
        },
      ),
    ],
  );

  static Future<String?> loginChecker() async {
    final isLoggedIn =
        await fCon.getValueFromStorage(value: StringConst.isLoggedIn);
    if (isLoggedIn != "true") {
      return RouteConstants.path.login;
    } else {
      return null;
    }
  }
}
