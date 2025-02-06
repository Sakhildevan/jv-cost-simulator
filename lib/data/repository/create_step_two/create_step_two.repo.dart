import 'package:johnsonville_cost_simulator/data/model/step_two_simulator.model.dart';
import 'package:johnsonville_cost_simulator/data/provider/create_step_two/create_step_two.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class CreateStepTwoRepo {
  //*--------(provider instance)
  final CreateStepTwoProvider stepTwoProvider =
      autoInjector.get<CreateStepTwoProvider>();
  Future<StepTwoSimulatorModel> createStepTwo({
    required Object requestBody,
  }) async {
    try {
      final StepTwoSimulatorModel response =
          await stepTwoProvider.createStepTwo(
        requestBody: requestBody,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
