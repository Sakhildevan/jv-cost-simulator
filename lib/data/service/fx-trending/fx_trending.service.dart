import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class FxTrendingService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;

  Future<Response<dynamic>?> getFxLineGraphList() async {
    try {
      return await _dio.post(
        ApiConst.fxLineGraphEndPoint,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      rethrow;
    }
  }
}
