import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helpers/local_database/local_prefs.dart';
import '../helpers/local_database/sharedpref_key.dart';
import '../helpers/utils/utils.dart';
import 'base_api_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        try {
          final uri = Uri.parse(url);

          final response = await http.get(uri, headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":
                'Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}'
          }).timeout(const Duration(seconds: 250));

          if (kDebugMode) {
            print('------URL-------');
            print("GETURL ${response.request?.url}");
            print(response.statusCode);
            print('------response-------');
            print("GETResponse  ${response.body}");
          }

          return returnResponse(response);
        } on SocketException {
          throw InternetException();
        } on TimeoutException {
          throw RequestTimeOut();
        } on Exception catch (e) {
          throw Exception(e);
        }
      } catch (error) {
        throw (error.toString());
      }
    } else {
      Utils.showErrorMessage('No internet connection!');
    }
  }

  @override
  Future<dynamic> postApi(data, String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final uri = Uri.parse(url);
        try {
          if (kDebugMode) {
            print("PostUrl $uri");
            print("----PostReq-- $data------");
          }

          final response =
              await http.post(uri, body: jsonEncode(data), headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":
                'Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}'
          }).timeout(const Duration(seconds: 250));

          if (kDebugMode) {
            print('------URL-------');
            print("PostURL ${response.request?.url}");
            print(response.statusCode);
            print('------response-------');
            print("PostResponse  ${response.body}");
          }

          return returnResponse(response);
        } on SocketException {
          throw InternetException();
        } on TimeoutException {
          throw RequestTimeOut();
        } on Exception {
          throw Exception();
        }
      } catch (error) {
        if (kDebugMode) {
          print('------ERROR-------');
          print(error);
          // Logger.log(error, stackTrace: stackTrace);
        }
        throw (error.toString());

        rethrow;
      }
    } else {
      Utils.showErrorMessage('No internet connection!');
    }
  }
}

dynamic returnResponse(http.Response response) {
  String? message = json.decode(response.body)['message'];
  switch (response.statusCode) {
    case 200:
      if (json.decode(response.body)['status'] == 500) {
        if (kDebugMode) {
          print('------URL500-------');
          print("${response.request?.url} URL500");
        }
      }
      return json.decode(response.body);
    case 400:
      // throw BadRequest();
      throw (message ?? 'Something went wrong, please try again.');
    case 401:
      throw Unauthorized();
    case 403:
      throw Forbidden();
    case 404:
      throw NotFound();
    case 408:
      throw RequestTimeOut();
    case 500:
      // throw InternalServerError();
      throw (message ?? 'Something went wrong, please try again.');
    case 502:
      throw BadGateway();
    default:
      throw FetchDataException("Something Went Wrong ${response.statusCode}");
  }
}
