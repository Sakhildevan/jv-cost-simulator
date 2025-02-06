import 'package:johnsonville_cost_simulator/utils/logger_extension';
import '../../../main.dart';
import '../../model/cost_simulator.model.dart';
import '../../service/simulator-list/cost_simulator.service.dart';

class SimulatorListProvider {
  //*--------(service instance)
  final CostSimulatorService simulatorListService =
      autoInjector.get<CostSimulatorService>();
  Future<CostSimulatorListModel> getCostSimulatorList({
    required String costSimulatorStatus,
    required String listCount,
    String? fromDate,
    String? toDate,
    String? currencyCode,
    String? searchQuery,
  }) async {
    //!----------------(getCostSimulatorList)----------------

    try {
      final response = await simulatorListService.getCostSimulatorList(
        fromDate: fromDate,
        toDate: toDate,
        currencyCode: currencyCode,
        listCount: listCount,
        costSimulatorStatus: costSimulatorStatus,
        searchQuery: searchQuery,
      );
      final CostSimulatorListModel model = CostSimulatorListModel.fromJson(
          response?.data as Map<String, dynamic>);
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
