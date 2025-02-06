import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/delivery_to_resp.model.dart';
import '../../provider/delivery-to/delivery_to.provider.dart';

class DeliveryToRepo {
  final DeliveryToProvider _provider = autoInjector.get<DeliveryToProvider>();
//*---------fetch DeliveryTo
  Future<DeliveryToRespModel?> fetchDeliveryTo() async {
    try {
      final DeliveryToRespModel response = await _provider.fetchDeliveryTo();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
