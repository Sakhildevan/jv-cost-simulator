// class RoutesConstants {
//   //*-------(initial)
//   static String initialRoute = '/';
//   static String initial = 'initial';
// //*---------(Step one)
//   static String stepOneRoute = '/Step-one';
//   static String stepOne = 'Step One';
// //*---------(Step two)
//   static String stepTwoRoute = '/Step-two';
//   static String stepTwo = 'Step two';
// //*----------(Home)
//   static String homeRoute = '/home';
//   static String home = 'home';
// //*----------(Pricing)
//   static String pricingRoute = '/pricing';
//   static String pricing = 'pricing';
//   //*--------(pending simulator)
//   static String pendingSimulatorRoute = '/pendingSimulator';
//   static String pendingSimulator = 'pendingSimulator';
// }

class RouteConstants {
  RouteConstants._();

  static const $RoutePath path = $RoutePath();
  static const $RouteName name = $RouteName();
}

class $RoutePath {
  const $RoutePath();
  String get initial => '/';
  String get stepOne => '/stepOne';
  String get stepTwo => '/stepTwo';
  String get home => '/home';
  String get login => '/login';
  String get pricing => '/pricing';
  String get simulatorCategory => '/simulatorCategory';
}

class $RouteName {
  const $RouteName();
  String get initial => 'initial';
  String get stepOne => 'stepOne';
  String get stepTwo => 'stepTwo';
  String get home => 'home';
  String get login => 'login';
  String get pricing => 'pricing';
  String get simulatorCategory => 'simulatorCategory';
}
