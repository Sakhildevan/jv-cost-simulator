import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/constants/api_constants.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

class FilterService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  Future<Response<dynamic>?> getFilterList({
    required String fromDate,
    required String toDate,
    required String currencyCode,
    required String listCount,
    required String costSimulatorStatus,
  }) async {
    final Object body = <String, String>{
      'fromDate': fromDate,
      'toDate': toDate,
      'currencyCode': currencyCode,
      'listCount': listCount,
      'costSimulatorStatus': costSimulatorStatus,
    };
    try {
      return await _dio.get(
        ApiConst.filterEndPoint,
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
