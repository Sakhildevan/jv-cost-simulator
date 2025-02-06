import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/business_unit_resp.model.dart';
import '../../service/business-unit/business_unit.service.dart';

class BusinessUnitProvider {
  final BusinessUnitService _service = autoInjector.get<BusinessUnitService>();
  //*---- fetch business unit
  Future<BusinessUnitRespModel> fetchBusinessUnit() async {
    try {
      final response = await _service.fetchBusinessUnit();
      final BusinessUnitRespModel model = BusinessUnitRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
