import 'package:alpha_app/Universals/Models/BaseResponse.dart';
import 'package:alpha_app/Universals/networking/StatusCodeConstant.dart';

class ResonseHelper {
  static bool checkApiResponse(BaseResponse response) {
    switch (response.status) {
      case StatusCodeConstant.sucessCode:
        return true;
      case StatusCodeConstant.notFoundCode:
        return false;
      case StatusCodeConstant.serverErrorCode:
        return false;
      case StatusCodeConstant.tokenExpiredCode:
        return false;
      case StatusCodeConstant.wrongCredentailCode:
        return false;        
      default:
        return false;
    }
  }
}
