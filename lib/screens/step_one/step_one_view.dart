import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/step_one_bloc/step_one_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'step_one_large_view.dart';
import 'step_one_small_view.dart';

class StepOneView extends StatelessWidget {
  const StepOneView({
    super.key,
    required this.simulatorId,
  });
  final String simulatorId;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepOneBloc>().add(StepOneInitial(
            simId: simulatorId,
          ));
    });
    //note: this api is called to fetch step two updated data

    return SelectionArea(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ScreenTypeLayout.builder(
      desktop: (BuildContext context) => StepOneLargeView(),
      tablet: (BuildContext context) => StepOneLargeView(),
      mobile: (BuildContext context) => const StepOneSmallView(),
    );
  }
}
