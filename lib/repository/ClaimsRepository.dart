import 'package:alpha_app/networking/ApiProvider.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';

class ClaimsRepository{
  ApiProvider apiProvider = new ApiProvider();

   Future<dynamic> callAddClaimsApi(Map parameter) async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken(parameter, NetworkConstant.ADD_CLAIM);
  return response;
  }

}