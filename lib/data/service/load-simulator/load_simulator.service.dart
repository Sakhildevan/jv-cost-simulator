import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class LoadCostSimulatorService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  Future<Response<dynamic>?> getCostLoadSimulatorList({
    required String costSimulatorId,
  }) async {
    final Object body = <String, String>{
      "costSimulatorID": costSimulatorId,
    };
    try {
      return await _dio.post(
        ApiConst.loadCostSimulatorEndpoint,
        data: body,
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
