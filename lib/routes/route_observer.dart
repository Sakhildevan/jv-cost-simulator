import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  String? _previousRouteName;

  String? get previousRouteName => _previousRouteName;

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _previousRouteName = previousRoute.settings.name;
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      _previousRouteName = previousRoute.settings.name;
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      _previousRouteName = oldRoute.settings.name;
    }
  }
}
