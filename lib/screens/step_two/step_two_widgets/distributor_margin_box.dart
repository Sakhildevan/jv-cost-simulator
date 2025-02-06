import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/step_two_bloc/step_two_bloc.dart';
import '../../../config/config.dart';
import '../../../utils/enums.dart';
import '../../../widgets/custom_box_title.dart';

//!------------------------------------DistributorMarginBox Page-----------------------------------------!
class DistributorMarginBox extends StatelessWidget {
  const DistributorMarginBox({super.key});

  @override
  Widget build(BuildContext context) {
    //!---------Menu Controllers----------------
    // MenuController distributorMenutrl = MenuController();
    //!---------Text Controllers----------------
    // final TextEditingController distributorTxtCtrl = TextEditingController();
    // final TextEditingController distCommentCtrl = TextEditingController();
    //!---------PostFrameCallback----------------
    // void addPostFrameCallback() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     final state = context.read<StepTwoBloc>().state;
    //     updateTextController(
    //       distributorTxtCtrl,
    //       state.costSimulatorDetails.estDistributorMarginOn,
    //       showPercentage: true,
    //     );
    //     updateTextController(
    //       distCommentCtrl,
    //       state.commentFields.estDistMarginComment,
    //     );
    //   });
    // }

    //!----------CustomBoxTitle----------------
    return BlocConsumer<StepTwoBloc, StepTwoState>(
      listener: (context, state) {
        // addPostFrameCallback();
      },
      builder: (context, state) {
        // addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return uiCon.shimmerLoader(
            type: ShimmerType.box,
          );
        }
        return const CustomBoxTitle(
          title: "",
          showIcon: false,
          child: SizedBox(),
        );
      },
    );
  }
}
