import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:inject/inject.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
@singleton
class HttpClient {
  final Client _client = Client();
  final Logger _logger;

  final String tag = "HttpClient";

  HttpClient(this._logger);

  Future<String> get(String url) async {
    try {
      var response = await _client.get(url, headers: {
        // Add Auth Header Here!
      });

      if (response.statusCode > 200 && response.statusCode < 300) {
        _logger.info(tag, response.body);
        return response.body;
      } else {
        _logger.error(tag, response.statusCode.toString() + ' for link ' + url);
        Fluttertoast.showToast(
            msg: "Error Code " +
                response.statusCode.toString() +
                ' Please Retry',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<String> post(String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      var response = await _client.post(url,
          headers: {
            // Add Auth Header Here!
          },
          body: json.encode(payLoad));

      if (response.statusCode > 200 && response.statusCode < 300) {
        _logger.info(tag, response.body);
        return response.body;
      } else {
        _logger.error(tag, response.statusCode.toString());
        _logger.error(tag, response.body);
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<String> put(String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      var response = await _client.put(url,
          headers: {
            // Add Auth Header Here!
          },
          body: json.encode(payLoad));

      if (response.statusCode > 200 && response.statusCode < 300) {
        _logger.info(tag, response.body);
        return response.body;
      } else {
        _logger.error(tag, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
