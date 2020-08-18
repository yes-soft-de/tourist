import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_comment/request/create_comments/create_comments.dart';
import 'package:tourists/module_comment/response/create_comment/create_comment_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class CommentRepository {
  final HttpClient _client;

  CommentRepository(this._client);

  getCommentsOfLocation() {}

  Future<CreateCommentResponse> createComment(
      CreateCommentRequest request) async {
    Map response = await _client.post(Urls.comment, request.toJson());

    if (response != null) {
      return CreateCommentResponse.fromJson(response);
    }
    return null;
  }

  Future<List<CreateCommentResponse>> getLocationComments(String locationId) {
    return null;
  }

  Future<List<CreateCommentResponse>> getGuideComments(String guideId) {
    return null;
  }
}
