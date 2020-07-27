import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/create_comments/create_comments.dart';
import 'package:tourists/responses/create_comment/create_comment_response.dart';

@provide
class CommentRepository {
  final HttpClient _client;

  CommentRepository(this._client);

  getCommentsOfLocation() {}

  Future<CreateCommentResponse> createComment(
      CreateCommentRequest request) async {
    String response = await _client.post(Urls.comment, request.toJson());

    if (response != null) {
      return CreateCommentResponse.fromJson(jsonDecode(response));
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
