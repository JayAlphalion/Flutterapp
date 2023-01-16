import 'package:alpha_app/networking/ApiProvider.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDataRespository {
  ApiProvider apiProvider = new ApiProvider();

  Future<dynamic> callGetChatHistoryApi(Map parameter) async {
    var response =await
        apiProvider.postAfterAuthWithFromDataParameter(parameter, NetworkConstant.GET_CHAT_HISTORY_API);
  return response;
  }
}
