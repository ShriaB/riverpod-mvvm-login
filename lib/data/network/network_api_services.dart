import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_login/data/api_exceptions.dart';
import 'package:riverpod_mvvm_login/data/network/base_api_services.dart';
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic responseData;

  /// Takes the url string and sends a get request
  /// If request was successful then returns the parsed json
  /// Else throws exceptions
  @override
  Future getData(String url) async {
    try {
      Response apiResponse = await get(Uri.parse(url));
      responseData = getDataFromJson(apiResponse);
      return responseData;
    } on SocketException {
      /// No internet connectivity
      rethrow;
    } on UnauthorisedException {
      rethrow;
    } on ServerError {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// Takes url string, request body and headers, Sends a post request to the url with the body
  /// If request was successful then returns the parsed json
  /// Else throws exceptions
  @override
  Future<dynamic> postData(String url, {body, headers}) async {
    try {
      Response apiResponse =
          await post(Uri.parse(url), body: body, headers: headers);
      responseData = getDataFromJson(apiResponse);
      return responseData;
    } on SocketException {
      /// No internet connectivity
      rethrow;
    } on UnauthorisedException {
      rethrow;
    } on ServerError {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// If request was successful then returns decoded json of the response body
  /// Else throws exceptions based on the status code returned
  dynamic getDataFromJson(Response apiResponse) {
    switch (apiResponse.statusCode) {
      case 200:
        {
          return jsonDecode(apiResponse.body);
        }
      case 400:
        {
          /// Either user is not authorised or entered wrong credentials
          throw UnauthorisedException();
        }
      case 500:
        {
          /// Some error on the server side
          throw ServerError();
        }
    }
  }
}

final apiServiceProvider =
    Provider<BaseApiServices>((ref) => NetworkApiServices());
