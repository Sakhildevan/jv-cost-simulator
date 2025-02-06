import 'package:johnsonville_cost_simulator/data/model/save_comment.model.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/comment_field_response.model.dart';
import '../../provider/comments/comments.provider.dart';

class CommentsRepo {
  //*--------(provider instance)
  final CommentsProvider provider = autoInjector.get<CommentsProvider>();

  ///fetch comment field data
  Future<CommentFieldResponseModel> fetchCommentFieldData() async {
    try {
      final CommentFieldResponseModel response =
          await provider.fetchCommentFieldData();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  ///!----------------- save comment
  Future<SaveCommentModel> saveComment({
    required String costSimulatorID,
    required String commentFieldID,
    required String commentDescription,
  }) async {
    try {
      final SaveCommentModel response = await provider.saveComment(
        costSimulatorID: costSimulatorID,
        commentFieldID: commentFieldID,
        commentDescription: commentDescription,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}
