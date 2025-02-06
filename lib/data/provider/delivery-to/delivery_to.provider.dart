import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/delivery_to_resp.model.dart';
import '../../service/delivery-to/delivery_to.service.dart';

class DeliveryToProvider {
  final DeliveryToService _service = autoInjector.get<DeliveryToService>();
  //*---- fetch subsidiary
  Future<DeliveryToRespModel> fetchDeliveryTo() async {
    try {
      final response = await _service.fetchDeliveryTo();
      final DeliveryToRespModel model = DeliveryToRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
