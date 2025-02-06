import 'package:johnsonville_cost_simulator/data/model/comment_field_response.model.dart';
import 'package:johnsonville_cost_simulator/data/model/save_comment.model.dart';
import 'package:johnsonville_cost_simulator/data/service/comments/comments.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class CommentsProvider {
  //*--------(service instance)
  final CommentsService service = autoInjector.get<CommentsService>();

  ///fetch comment field data
  Future<CommentFieldResponseModel> fetchCommentFieldData() async {
    try {
      final response = await service.fetchCommentFieldData();

      final CommentFieldResponseModel model =
          CommentFieldResponseModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  ///!-------------Save comment
  Future<SaveCommentModel> saveComment({
    required String costSimulatorID,
    required String commentFieldID,
    required String commentDescription,
  }) async {
    try {
      final response = await service.saveComment(
        costSimulatorID: costSimulatorID,
        commentFieldID: commentFieldID,
        commentDescription: commentDescription,
      );

      final SaveCommentModel model = SaveCommentModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
