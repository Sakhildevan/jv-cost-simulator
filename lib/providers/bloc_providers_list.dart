// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/single_child_widget.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/simulator_category/simulator_category_bloc.dart';
import '../bloc/step_one_bloc/step_one_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/step_two_bloc/step_two_bloc.dart';

List<SingleChildWidget> blocProviderList = [
  //*----(Login bloc)
  BlocProvider(create: (context) => LoginBloc()),
  //*--------(Home bloc)
  BlocProvider(
    create: (context) => HomeBloc(),
  ),
//*--------(step one)
  BlocProvider(create: (context) => StepOneBloc()),
  //*--------(step two)
  BlocProvider(create: (context) => StepTwoBloc()),
  //*--------(Pending simulator)
  BlocProvider(create: (context) => SimulatorCategoryBloc()),
  BlocProvider(create: (context) => PricingBloc()),
];
