import 'package:inject/inject.dart';
import 'package:tourists/module_comment/repository/comment/comment_repository.dart';
import 'package:tourists/module_comment/request/create_comments/create_comments.dart';
import 'package:tourists/module_comment/response/create_comment/create_comment_response.dart';

@provide
class CommentManager {
  final CommentRepository _repository;
  CommentManager(this._repository);

  Future<CreateCommentResponse> createComment(
      CreateCommentRequest createCommentRequest) {
    return this._repository.createComment(createCommentRequest);
  }

  Future<List<CreateCommentResponse>> getLocationComments(String locationId) {
    return this._repository.getLocationComments(locationId);
  }

  Future<List<CreateCommentResponse>> getGuideComments(String guideId) {
    return this._repository.getGuideComments(guideId);
  }
}
