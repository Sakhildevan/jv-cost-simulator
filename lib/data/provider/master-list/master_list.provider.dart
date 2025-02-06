import 'package:johnsonville_cost_simulator/main.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../model/filter_master_list.model.dart';
import '../../service/master-list/master_list.service.dart';

class MasterListProvider {
  //*--------(service instance)
  final MasterListService simService = autoInjector.get<MasterListService>();
  Future<FilterMasterModel> fetchMasterList() async {
    try {
      final response = await simService.fetchMasterList();

      final FilterMasterModel model = FilterMasterModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
