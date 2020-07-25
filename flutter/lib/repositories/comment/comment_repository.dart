import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/create_comments/create_comments.dart';

@provide
class CommentRepository {
  final HttpClient _client;
  CommentRepository(this._client);

  getCommentsOfLocation() {

  }

  createComment(CreateCommentRequest request) {
    _client.post(Urls.comment, request.toJson());
  }
}