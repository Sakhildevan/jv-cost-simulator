import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class UpdateFieldsService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;

  //--------fetch update field data
  Future<Response<dynamic>?> fetchUpdateFieldData() async {
    try {
      return await _dio.get(
        ApiConst.updateFieldEndPoint,
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

  //--------fetch update field data
  Future<Response<dynamic>?> updateSheetValue({
    required String simId,
    required String updateFieldId,
    required String updateFieldValue,
    required String userId,
  }) async {
    try {
      return await _dio.post(
        ApiConst.updateSheetValueEndPoint,
        data: {
          "CostSimulatorID": simId,
          "UpdateFieldID": updateFieldId,
          "UpdateFieldValue": updateFieldValue,
          "UserID": userId,
        },
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
