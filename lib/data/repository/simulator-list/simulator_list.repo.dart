import 'package:johnsonville_cost_simulator/data/provider/simulator-list/simulator_list.provider.dart';

import '../../../main.dart';
import '../../model/cost_simulator.model.dart';

class SimulatorListRepo {
  //*--------(provider instance)
  final SimulatorListProvider simulatorListProvider =
      autoInjector.get<SimulatorListProvider>();

  Future<CostSimulatorListModel?> getCostSimulatorList({
    required String costSimulatorStatus,
    required String listCount,
    String? fromDate,
    String? toDate,
    String? currencyCode,
    String? searchQuery,
  }) async {
    try {
      final CostSimulatorListModel response =
          await simulatorListProvider.getCostSimulatorList(
        fromDate: fromDate,
        toDate: toDate,
        currencyCode: currencyCode,
        listCount: listCount,
        costSimulatorStatus: costSimulatorStatus,
        searchQuery: searchQuery,
      );
      return response;
    } catch (e) {
      // Handle the exception here
    }
    return null;
  }
}
