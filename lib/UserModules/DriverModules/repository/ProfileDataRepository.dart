import 'package:alpha_app/Universals/networking/ApiProvider.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDataRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<dynamic> callGetProfileData() async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken({}, NetworkConstant.GET_DRIVER_INFO);
  return response;
  }
}
