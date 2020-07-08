import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:inject/inject.dart';

@provide
@singleton
class HttpClient {
  final Client _client = Client();

  Future<String> get(String url) async {
    try {
      var response = await _client.get(url, headers: {
        // Add Auth Header Here!
      });

      if (response.statusCode == 200) {
        log(response.body);
        Fluttertoast.showToast(
            msg: "OK!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        return response.body;
      } else {
        // TODO: Implement This, Log Error
        log(response.statusCode.toString() + ' for link ' + url);
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
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<String> post(String url, Map<String, dynamic> payLoad) async {
    try {
      log('Requesting Post to: ' + url);
      var response = await _client.post(url,
          headers: {
            // Add Auth Header Here!
          },
          body: json.encode(payLoad));

      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        // TODO: Implement This, Log Error
        log(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<String> put(String url, Map<String, dynamic> payLoad) async {
    try {
      log('Requesting Post to: ' + url);
      var response = await _client.put(url,
          headers: {
            // Add Auth Header Here!
          },
          body: json.encode(payLoad));

      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        // TODO: Implement This, Log Error
        log(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
