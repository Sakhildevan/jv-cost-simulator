import 'package:johnsonville_cost_simulator/data/service/auth/login.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/login.model.dart';

class LoginProvider {
  //*--------(service instance)
  final LoginServices loginService = autoInjector.get<LoginServices>();
  Future<LoginModel> login({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await loginService.login(
        userName: userName,
        password: password,
      );
      final LoginModel model =
          LoginModel.fromJson(response?.data as Map<String, dynamic>);
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
