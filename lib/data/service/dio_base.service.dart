import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioBaseService {
  static late Dio _dio;
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env[Config.baseURL] ?? "",
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    _prefs = await SharedPreferences.getInstance();

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) {
        final String? token = _prefs?.getString(StringConst.loginToken);
        if (token != null) {
          options.headers[Config.loginToken] = token;
        }
        return handler.next(options);
      },
    ));
  }

  static Dio get dio {
    return _dio;
  }
}
