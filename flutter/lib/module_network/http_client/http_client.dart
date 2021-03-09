import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_network/network_client/network_client.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class HttpClient extends NetworkClient {
  Dio _client;
  final _logger = Logger();

  final String tag = 'HttpClient';

  HttpClient() {
    _client = new Dio(BaseOptions());
    _client.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: Urls.baseAPI)).interceptor);
  }

  @override
  Future<Map<String, dynamic>> get(String url, {Map<String, String> queryParams}) async {
    _logger.info(tag, 'GET $url');
    try {
      Response response = await _client.get(
        url,
        options: buildCacheOptions(Duration(seconds: 2)),
        queryParameters: queryParams
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, response.statusCode.toString() + ' for link ' + url);
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      Response response = await _client.post(url, data: json.encode(payLoad));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, response.statusCode.toString());
        _logger.error(tag, response.data.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Put to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      var response = await _client.put(url, data: json.encode(payLoad));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      return null;
    }
  }
}
