import 'package:alpha_app/networking/ApiProvider.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<dynamic> callLoginApi(Map paramter) async {
    var response =await
        apiProvider.postBeforeAuth(paramter, NetworkConstant.DriverLog);
  return response;
  }
}
