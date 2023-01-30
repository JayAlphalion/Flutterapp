import 'package:alpha_app/Universals/Models/BaseResponse.dart';
import 'package:alpha_app/Universals/networking/ApiProvider.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/networking/RealApiProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Universals/networking/Response.dart';

class AuthRepository {
  ApiProvider apiProvider = new ApiProvider();
  RealApiProvider realApiProvider = new RealApiProvider();

  
  Future<Response<BaseResponse>> callGetOtpApi(Map paramter) async {
    var response = await realApiProvider.postBeforeAuth(
        parameter: paramter, url: NetworkConstant.END_POINT_GET_OTP);
    return response;
  }

  Future<Response<BaseResponse>> callVerifyOtpApi(
      Map paramter,token) async {
    var response = await realApiProvider.postBeforeAuthWithAuthToken(
        parameter: paramter,token: token,
        url: NetworkConstant.END_POINT_VERIFY_OTP,
       );
    return response;
  }
}
