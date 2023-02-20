import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/Universals/utils/SharedPrefs.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

import 'CustomException.dart';
import 'NetworkConstant.dart';

class ApiProvider {
  final String baseUrl = NetworkConstant.BASE_URL;
  final String beforeAuth = NetworkConstant.MIDDLE_URL;
  final String afterAuth = NetworkConstant.MIDDLE_URL;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
      );
      // debugger();
      // print(response.body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAfterAuth(String url) async {
    SharedPref box = new SharedPref();
    String? token = await box.getToken();

    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + afterAuth + url),
        headers: {
          "authorization": "Bearer " + token,
          "Accept": "application/json"
        },
      );
      // debugger();
      // print(response.body);
      responseJson = _response(response);
    } catch (e) {
      debugger();
      print(e);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postBeforeAuth(Map parameter, String url) async {
    // debugger();
    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + beforeAuth + url),
          body: parameter);
      return response;
    } catch (e) {
      print(e);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuth(Map parameter, String url) async {
    var responseJson;

    try {
      final response = await http.post(Uri.parse(baseUrl + afterAuth + url),
          headers: {'Content-type': 'application/json'},
          body: json.encode(parameter));
      responseJson = _response(response);
    } catch (e) {
      print(e);

      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthWithAuthToken(Map parameter, String url) async {
    var responseJson;
    String? token = await SharedPref().getUserToken();
    try {
      final response = await http.post(Uri.parse(baseUrl + afterAuth + url),
          headers: {
            'Content-type': 'application/json',
            'authorization': 'Bearer ' + token!,
          },
          body: json.encode(parameter));
    
      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        return res;
      } else {
        NetworkConstant.FAILURE;
      }
    } catch (e) {
      //debugger();
      print(e);
      return NetworkConstant.FAILURE;
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthCustom(Map parameter, String url) async {
    var responseJson;
    String? token = await SharedPref().getUserToken();
    try {
      final response = await http.post(Uri.parse(baseUrl + afterAuth + url),
          headers: {
            'Content-type': 'application/json',
            'authorization': 'Bearer ' + token!,
          },
          body: json.encode(parameter));

      return response.body;
    } catch (e) {
      print(e);

      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthWithFromDataParameter(
      Map parameter, String url) async {
    var responseJson;
    String? token = await SharedPref().getUserToken();
    try {
      final response = await http.post(Uri.parse(baseUrl + afterAuth + url),
          headers: {
            'authorization': 'Bearer ' + token!,
          },
          body: parameter);

      return json.decode(response.body);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthWithMultipart(
      Map parameter, String url, List<File> files) async {
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
          responseJson = _response(response);
        });
      });
    } catch (e) {
      debugger();
      print(e);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthMultipart(
      Map parameter, String url, File files) async {
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
          responseJson = _response(response);
        });
      });
    } catch (e) {
      debugger();
      print(e);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthMultipartForUploadBusinessPhoto(
      Map parameter, String url, File files) async {
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
          'image_param_name',
          (http.ByteStream(files.openRead())).cast(),
          await files.length(),
          filename: basename(files.path),
        ),
      );

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          responseJson = _response(response);
        });
      });
    } catch (e) {
      debugger();
      print(e);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
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
