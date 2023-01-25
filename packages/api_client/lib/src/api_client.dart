import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:api_client/src/models/beer.dart';
import 'package:api_client/src/models/request_status.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "api.punkapi.com";
  final http.Client _httpClient;

  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<RequestStatus<List<Beer>>> getBeers({int page = 1}) async {
    try {
      final query = {
        "page": "$page",
        "per_page": "10",
      };
      final response =
          await _httpClient.get(Uri.https(baseUrl, "/v2/beers", query));

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        final List<Beer> beers =
            body.map((dynamic item) => Beer.fromJson(item)).toList();
        return RequestStatus<List<Beer>>(RequestStatus.SUCCESS, null, beers);
      } else {
        return _checkErrorCode<List<Beer>>(response);
      }
    } catch (e) {
      return _commonCatchBlock(e);
    }
  }

  /// To be used inside else block of non 200 response codes
  /// It returns requestStatus with appropriate message
  /// according to the response error codes
  RequestStatus<T> _checkErrorCode<T>(http.Response response) {
    // print(" ${response.statusCode}");
    // print(" ${response.reasonPhrase}");

    if (500 > response.statusCode && response.statusCode >= 400) {
      String msg = jsonDecode(response.body)['message'] ??
          jsonDecode(response.body)['error'] ??
          'Something went wrong';
      return RequestStatus<T>(RequestStatus.FAILURE, msg, null);
    } else {
      ////print("Status Code: ${response.statusCode}");
      log("Reason phase: ${response.reasonPhrase}");
      throw Exception("Response code is ${response.statusCode}");
    }
  }

  /// Used inside every catch block of api call
  /// It returns Failed [RequestStatus] with appropriate message
  RequestStatus<T> _commonCatchBlock<T>(e) {
    if (e is TimeoutException || e is SocketException) {
      return RequestStatus<T>(
          RequestStatus.FAILURE, 'Check internet connection', null);
    }
    ////print(e);
    return RequestStatus<T>(
        RequestStatus.FAILURE, 'Something went wrong', null);
  }
}
