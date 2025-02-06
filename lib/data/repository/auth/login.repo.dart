import 'package:johnsonville_cost_simulator/data/provider/auth/login.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/login.model.dart';

class LoginRepo {
  //*--------(provider instance)
  final LoginProvider loginProvider = autoInjector.get<LoginProvider>();

  Future<LoginModel> login({
    required String userName,
    required String password,
  }) async {
    try {
      final LoginModel response = await loginProvider.login(
        userName: userName,
        password: password,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
