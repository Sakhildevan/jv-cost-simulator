import 'package:johnsonville_cost_simulator/data/service/currency/currency_list.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/currency_list.model.dart';

class CurrencyListProvider {
  //*--------(service instance)
  final CurrencyListService currencyService =
      autoInjector.get<CurrencyListService>();
  Future<CurrencyListModel> fetchCurrencyList() async {
    try {
      final response = await currencyService.fetchCurrencyList();
      final CurrencyListModel model =
          CurrencyListModel.fromJson(response?.data as Map<String, dynamic>);
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
