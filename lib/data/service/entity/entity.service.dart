import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class EntityService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  // fetch entity list
  Future<Response<dynamic>?> fetchEntityData({
    required String geoLocationId,
  }) async {
    Object body = {
      "gioLocationID": geoLocationId,
    };
    try {
      return await _dio.post(
        ApiConst.entityEndPoint,
        data: body,
      );
    } on DioException catch (e) {
      // Handle DioError
      log('Dio error: $e');
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      // Return null or rethrow the DioError to propagate it further
      rethrow;
    }
  }
}
