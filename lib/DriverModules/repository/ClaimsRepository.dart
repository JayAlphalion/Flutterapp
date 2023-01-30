import 'package:alpha_app/Universals/networking/ApiProvider.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';

class ClaimsRepository{
  ApiProvider apiProvider = new ApiProvider();

   Future<dynamic> callAddClaimsApi(Map parameter) async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken(parameter, NetworkConstant.ADD_CLAIM);
  return response;
  }



  Future<dynamic> getPreviousClaimData(Map parameter) async {
    var response =await
        apiProvider.postAfterAuthWithAuthToken(parameter, NetworkConstant.GET_PREVIOUS_CLAIM);
  return response;
  }

}