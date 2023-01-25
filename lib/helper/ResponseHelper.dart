import 'package:alpha_app/Model/responses/BaseResponse.dart';
import 'package:alpha_app/networking/StatusCodeConstant.dart';

class ResonseHelper {
 static bool checkApiResponse(BaseResponse response) {
    switch (response.status) {
      case StatusCodeConstant.sucessCode:
        return true;
      case StatusCodeConstant.notFoundCode:
        return false;
      case StatusCodeConstant.serverErrorCode:
        return false;
      default:
        return false;
    }
  }
}
