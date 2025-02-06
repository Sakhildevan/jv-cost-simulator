import 'package:johnsonville_cost_simulator/data/model/step_two_simulator.model.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../service/create_step_two/create_step_two.service.dart';

class CreateStepTwoProvider {
  //*--------(service instance)
  final CreateStepTwoService stepTwoService =
      autoInjector.get<CreateStepTwoService>();
  Future<StepTwoSimulatorModel> createStepTwo({
    required Object requestBody,
  }) async {
    try {
      final response = await stepTwoService.createStepTwo(
        requestBody: requestBody,
      );

      final StepTwoSimulatorModel model = StepTwoSimulatorModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
