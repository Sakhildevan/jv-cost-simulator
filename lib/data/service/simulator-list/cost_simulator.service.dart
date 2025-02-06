import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../constants/api_constants.dart';
import '../dio_base.service.dart';

class CostSimulatorService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  //!----------------(getCostSimulatorList)----------------
  Future<Response<dynamic>?> getCostSimulatorList({
    required String costSimulatorStatus,
    required String listCount,
    String? fromDate,
    String? toDate,
    String? currencyCode,
    String? searchQuery,
  }) async {
    //!----------------(Dio post body)----------------
    final Object body = <String, String>{
      "costSimulatorStatus": costSimulatorStatus,
      "listCount": listCount,
      "fromDate": fromDate ?? '',
      "toDate": toDate ?? '',
      "currencyCode": currencyCode ?? '',
      "SearchString": searchQuery ?? ""
    };
    //!----------------(Dio post)----------------
    try {
      return await _dio.post(
        ApiConst.costSimulatorEndpoint,
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
