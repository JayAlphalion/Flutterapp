import 'dart:convert';
import 'dart:developer';


import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final box = GetStorage();
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

 Future<String?>getUserToken()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(SharedPrefConstant.DRIVER_TOKEN);
    return token;
 }
  Future<String> getToken() async {
    String res= await box.read(SharedPrefConstant.DRIVER_TOKEN);
   
return res;
  }

  Future<bool> remove(String key) async {
    bool result;
    try {
      box.remove(key);
      result = true;
    } catch (e) {
      result = false;
    }
    return result;
  }

  Future<dynamic> getData(String key) async {
    String? result;
    try {
      result = box.read(key);
      return result;
    } catch (e) {
      result = null;
    }
  //  return result;
  }

  Future<bool> saveData(String key, value) async {
    bool result;
    try {
      box.write(key, value);
      result = true;
    } catch (e) {
      result = false;
    }
    return result;
  }

  // Future<String> getAuthKey() async {
  //   Map<String, dynamic>? userMap;
  //   String? userStr;
  //   try {
  //     userStr = box.read(PrefsKey.PREFKEY_USER);
  //     userMap = jsonDecode(userStr!) as Map<String, dynamic>;
  //   } catch (e) {
  //     userStr = null;
  //   }

  //   if (userMap != null) {
  //     final UserData user = UserData.fromJson(userMap);
  //     print("Authkey :" + user.authKey);
  //     return user.authKey;
  //   }
  //   return 'null';
  // }

  // Future<dynamic> getUserInfo() async {
  //   Map<String, dynamic>? userMap;
  //   String? userStr;
  //   try {
  //     userStr = box.read(PrefsKey.PREFKEY_USER);
  //   } catch (e) {
  //     print("gettting error");
  //   }
  //   if (userStr != null) {
  //     userMap = jsonDecode(userStr) as Map<String, dynamic>;
  //   }
  //   if (userMap != null) {
  //     final UserData user = UserData.fromJson(userMap);
  //     return user;
  //   }
  //   return 'null';
  // }
}