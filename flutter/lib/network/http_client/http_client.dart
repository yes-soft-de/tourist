import 'dart:convert';

import 'package:http/http.dart';
import 'package:inject/inject.dart';

@provide
@singleton
class HttpClient {
  final Client _client = Client();

  Future<String> get(String url) async {
    var response = await _client.get(url, headers: {
      // Add Auth Header Here!
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // TODO: Implement This, Log Error
      return '';
    }
  }

  Future<String> post(String url, Map<String, dynamic> payLoad) async {
    var response = await _client.post(url,
        headers: {
          // Add Auth Header Here!
        },
        body: json.encode(payLoad));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // TODO: Implement This, Log Error
      return '';
    }
  }
}
