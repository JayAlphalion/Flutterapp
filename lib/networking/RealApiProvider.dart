import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:alpha_app/Model/responses/BaseResponse.dart';
import 'package:alpha_app/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

import 'CustomException.dart';
import 'NetworkConstant.dart';
import 'Response.dart';

class RealApiProvider {
  final String baseUrl = NetworkConstant.BASE_URL;
  final String beforeAuth = NetworkConstant.MIDDLE_URL;
  final String afterAuth = NetworkConstant.MIDDLE_URL;

  Future<BaseResponse> getBeforeAuth({required String url}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
      );
      responseJson = _response(response);
      return BaseResponse.fromJson(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<Response<BaseResponse>> getAfterAuth({required String url}) async {
    SharedPref box = new SharedPref();
    String? token = await box.getToken();

    try {
      final response = await http.get(
        Uri.parse(baseUrl + afterAuth + url),
        headers: {
          "authorization": "Bearer " + token,
          "Accept": "application/json"
        },
      );
      return _response(response);
    } catch (e) {
      return Response.error('Server Error, Please Try Again Letter');
    }
  }

 

  Future<Response<BaseResponse>> postBeforeAuth(
      {required Map parameter, required String url}) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + beforeAuth + url),
          body: parameter);

      return _response(response);
    } catch (e) {
      return Response.error('Server Error, Please Try Again Letter');
    }
  }

  Future<Response<BaseResponse>> postAfterAuth(
      {
        required Map parameter, required String url}) async {
    String? token = await SharedPref().getUserToken();
    try {
      final response = await http.post(Uri.parse(baseUrl + afterAuth + url),
          headers: {
            'Content-type': 'application/json',
            'authorization': 'Bearer ' + token!,
          },
          body: json.encode(parameter));

      return _response(response);
    } catch (e) {
      return Response.error('Server Error, Please Try Again Letter');
    }
  }

  Future<Response<BaseResponse>> postAfterAuthWithListMultipart(
      {required Map parameter,
      required String url,
      required List<File> files}) async {
    SharedPref box = new SharedPref();
    String token = await box.getToken();

    var responseJson;
    Map<String, String> headers = {
      "authorization": "Bearer " + token,
      "Accept": "application/json"
    };

    try {
      final response =
          http.MultipartRequest("POST", Uri.parse(baseUrl + afterAuth + url));
      response.headers.addAll(headers);
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }

      await Future.forEach(
        files,
        (File file) async => {
          response.files.add(
            http.MultipartFile(
              'file',
              (http.ByteStream(file.openRead())).cast(),
              await file.length(),
              filename: basename(file.path),
            ),
          )
        },
      );

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          return _response(response);
        });
      });
    } catch (e) {
      return Response.error('Server Error, Please Try Again Letter');
    }
    return responseJson;
  }

  Future<Response<BaseResponse>> postAfterAuthMultipart(
      {required Map parameter,
      required String url,
      required File files}) async {
    SharedPref box = new SharedPref();
    String token = await box.getToken();
    // debugger();
    // print(files);
    var responseJson;
    Map<String, String> headers = {
      "authorization": "Bearer " + token,
      "Accept": "application/json"
    };

    try {
      final response =
          http.MultipartRequest("POST", Uri.parse(baseUrl + afterAuth + url));
      response.headers.addAll(headers);
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }

      response.files.add(
        http.MultipartFile(
          'file',
          (http.ByteStream(files.openRead())).cast(),
          await files.length(),
          filename: basename(files.path),
        ),
      );

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          return _response(response);
        });
      });
    } catch (e) {
      return Response.error('Server Error, Please Try Again Letter');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        // debugger();
        // print(responseJson);
        BaseResponse v = BaseResponse.fromJson(responseJson);
        return Response.completed(v, '');

      case 400:
        return Response.error('Server Error');
      // throw BadRequestException(response.body.toString());
      case 401:
        return Response.error('Server Error');
      case 403:
        return Response.error('Server Error');
      // throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        return Response.error('Server Error');
      // throw FetchDataException(
      //     'Error occured while Communication with Server with StatusCode : ${response.statusCode}');

    }
  }

  dynamic _responseFromStream(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
