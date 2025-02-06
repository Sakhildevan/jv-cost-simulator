import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/business_unit_resp.model.dart';
import '../../provider/business-unit/business_unit.provider.dart';

class BusinessUnitRepo {
  final BusinessUnitProvider _provider =
      autoInjector.get<BusinessUnitProvider>();
//*---------fetch Business unit
  Future<BusinessUnitRespModel?> fetchBusinessUnit() async {
    try {
      final BusinessUnitRespModel response =
          await _provider.fetchBusinessUnit();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
