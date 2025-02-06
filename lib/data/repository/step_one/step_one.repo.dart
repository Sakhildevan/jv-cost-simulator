import 'package:johnsonville_cost_simulator/data/provider/step_one/step_one.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/create_simulator.model.dart';

class CreateSimulatorRepo {
  //*--------(provider instance)
  final CreateSimulatorProvider simProvider =
      autoInjector.get<CreateSimulatorProvider>();
  Future<CreateSimulatorModel> createNewSimulator({
    required Object requestBody,
  }) async {
    try {
      final CreateSimulatorModel response =
          await simProvider.createNewSimulator(
        requestBody: requestBody,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
