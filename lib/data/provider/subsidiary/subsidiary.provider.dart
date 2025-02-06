import 'package:johnsonville_cost_simulator/data/model/subsidiary_resp.model.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../service/subsidiary/subsidiary.service.dart';

class SubsidiaryProvider {
  final SubsidiaryService _service = autoInjector.get<SubsidiaryService>();
  //*---- fetch subsidiary
  Future<SubsidiaryRespModel> fetchSubsidiary() async {
    try {
      final response = await _service.fetchSubsidiary();
      final SubsidiaryRespModel model = SubsidiaryRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
