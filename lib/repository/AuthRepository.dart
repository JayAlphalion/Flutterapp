import 'package:alpha_app/Model/responses/BaseResponse.dart';
import 'package:alpha_app/networking/ApiProvider.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:alpha_app/networking/RealApiProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../networking/Response.dart';

class AuthRepository {
  ApiProvider apiProvider = new ApiProvider();
  RealApiProvider realApiProvider = new RealApiProvider();

  Future<dynamic> callLoginApi(Map paramter) async {
    var response =
        await apiProvider.postBeforeAuth(paramter, NetworkConstant.DriverLog);
    return response;
  }

  Future<Response<BaseResponse>> callGetOtpApi(Map paramter) async {
    var response = await realApiProvider.postBeforeAuth(
        parameter: paramter, url: NetworkConstant.END_POINT_GET_OTP);
    return response;
  }
}
