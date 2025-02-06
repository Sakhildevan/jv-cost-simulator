import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api_constants.dart';
import '../dio_base.service.dart';

class DeliveryToService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  // fetch deliveryTo data
  Future<Response<dynamic>?> fetchDeliveryTo() async {
    try {
      return await _dio.get(
        ApiConst.deliveryToEndPoint,
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
