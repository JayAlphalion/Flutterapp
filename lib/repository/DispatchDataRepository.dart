import 'package:alpha_app/networking/ApiProvider.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DispatchDataRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<dynamic> callGetCurrentLoadDispatch() async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken({}, NetworkConstant.GET_CURRENT_DISPATCH);
  return response;
  }


  Future<dynamic> callGetUpcommingLoadRequestApi() async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken({}, NetworkConstant.GET_UPCOMMING_LOAD_REQUEST);
  return response;
  }

  Future<dynamic> callGetPastLoadDispatch() async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken({}, NetworkConstant.GET_PAST_DISPATCH);
  return response;
  }

}
