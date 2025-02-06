import 'package:johnsonville_cost_simulator/data/model/currency_list.model.dart';
import 'package:johnsonville_cost_simulator/data/provider/currency/currency_list.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class CurrencyListRepo {
  //*--------(provider instance)
  final CurrencyListProvider currencyProvider =
      autoInjector.get<CurrencyListProvider>();
  Future<CurrencyListModel> fetchCurrencyList() async {
    try {
      final CurrencyListModel response =
          await currencyProvider.fetchCurrencyList();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
