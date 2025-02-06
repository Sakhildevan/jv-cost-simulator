import 'package:johnsonville_cost_simulator/data/model/create_simulator.model.dart';
import 'package:johnsonville_cost_simulator/data/service/step_one/step_one.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class CreateSimulatorProvider {
  //*--------(service instance)
  final CreateSimulatorService simService =
      autoInjector.get<CreateSimulatorService>();
  Future<CreateSimulatorModel> createNewSimulator({
    required Object requestBody,
  }) async {
    try {
      final response = await simService.createNewSimulator(
        requestBody: requestBody,
      );

      final CreateSimulatorModel model = CreateSimulatorModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
