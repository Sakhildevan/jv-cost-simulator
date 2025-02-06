import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class CommentsService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;

  //--------fetch comment field data
  Future<Response<dynamic>?> fetchCommentFieldData() async {
    try {
      return await _dio.get(
        ApiConst.commentFieldEndPoint,
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

  //--------save comment data
  Future<Response<dynamic>?> saveComment({
    required String costSimulatorID,
    required String commentFieldID,
    required String commentDescription,
  }) async {
    try {
      Object body = {
        "costSimulatorID": costSimulatorID,
        "commentFieldID": commentFieldID,
        "commentDescription": commentDescription
      };
      return await _dio.post(
        ApiConst.saveCommentEndPoint,
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
