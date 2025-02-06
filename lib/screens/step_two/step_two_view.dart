import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/step_two_bloc/step_two_bloc.dart';
import 'step_two_large_view.dart';
import 'step_two_small_view.dart';

//!------------------------------------StepTwoView Page-----------------------------------------
class StepTwoView extends StatelessWidget {
  const StepTwoView({
    super.key,
    required this.simulatorId,
  });
  final String simulatorId;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepTwoBloc>().add(StepTwoInitial(
            id: simulatorId,
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
      desktop: (BuildContext context) => StepTwoLargeView(),
      tablet: (BuildContext context) => StepTwoLargeView(),
      mobile: (BuildContext context) => const StepTwoSmallView(),
    );
  }
}
