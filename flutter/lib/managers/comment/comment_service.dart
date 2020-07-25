import 'package:inject/inject.dart';
import 'package:tourists/repositories/comment/comment_repository.dart';
import 'package:tourists/requests/create_comments/create_comments.dart';

@provide
class CommentManager {
  CommentRepository _repository;
  CommentManager(this._repository);

  createComment(CreateCommentRequest createCommentRequest) {
    return this._repository.createComment(createCommentRequest);
  }
}