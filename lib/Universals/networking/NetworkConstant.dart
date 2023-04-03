import 'package:flutter/material.dart';

class NetworkConstant {
  static const String BASE_URL =
       'http://34.30.45.244/';
        // 'http://192.168.1.19/';
  static const String MIDDLE_URL = 'API/V2/';

  // api param...
  static const String API_PARAM_LOAD_NO = 'load_no';
  static const String API_PARAM_DRIVER_TOKEN = 'driver_token';
  static const String API_PARAM_ACCEPT = 'accept';
  static const String API_PARAM_USER_TOKEN = 'user_token';
  static const String API_PARAM_GROUP_ID = 'group_id';
  static const String API_PARAM_PHONE_NUMBER='phone_number';
  static const String API_PARAM_ENTERED_OTP='entered_otp';


// Route URL...
  static const String Ackload = 'ackload';
  static const String GET_CURRENT_DISPATCH = 'GetCurrDispatch';
  static const String GET_PAST_DISPATCH = 'getdriverpastload';
  static const String GET_DRIVER_INFO = 'getdriverinfo';
  static const String GET_UPCOMMING_LOAD_REQUEST = 'upcomingDispatch';
  static const String GET_CHAT_HISTORY_API = 'getchathistory';
  static const String ADD_CLAIM = 'opsdata';
  static const String GET_PREVIOUS_CLAIM='getopsdata';
  static const String END_POINT_GET_OTP='optvalidation';
  static const String END_POINT_VERIFY_OTP='validateotp';
// Constant.

  static const String SUCCESS = 'success';
  static const String FAILURE = 'failure';
  static const String MESSAGE = 'message';
}
