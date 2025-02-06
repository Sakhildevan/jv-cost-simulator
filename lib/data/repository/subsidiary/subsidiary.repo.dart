import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/subsidiary_resp.model.dart';
import '../../provider/subsidiary/subsidiary.provider.dart';

class SubsidiaryRepo {
  final SubsidiaryProvider _provider = autoInjector.get<SubsidiaryProvider>();
//*---------fetch Subsidiary
  Future<SubsidiaryRespModel?> fetchSubsidiary() async {
    try {
      final SubsidiaryRespModel response = await _provider.fetchSubsidiary();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
