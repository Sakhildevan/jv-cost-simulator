import 'package:johnsonville_cost_simulator/data/model/filter_master_list.model.dart';
import 'package:johnsonville_cost_simulator/data/provider/master-list/master_list.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class MasterListRepo {
  //*--------(Provider instance)
  final MasterListProvider simProvider = autoInjector.get<MasterListProvider>();
  Future<FilterMasterModel> fetchMasterList() async {
    try {
      final FilterMasterModel response = await simProvider.fetchMasterList();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
