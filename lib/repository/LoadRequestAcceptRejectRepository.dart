import 'package:alpha_app/networking/ApiProvider.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadRequestAcceptRejectRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<dynamic> callAcceptRejectloadMethod(Map paramter) async {
    var response =await
        apiProvider.postAfterAuthCustom(paramter, NetworkConstant.Ackload);
  return response;
  }
}
