import 'dart:async';

import 'package:flutter/services.dart';


class CompanyWechat {
  static const MethodChannel _channel = const MethodChannel('company_wechat');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> companyWeChatLogin(
      String appId, String agentId, String schema) async {
    var result = await _channel.invokeMethod(
        'companyWechatLogin', <String, dynamic>{
          'schema': schema,
          'appId' : appId,
          'agentId' : agentId,
        });
    print("result"+result);
    return result;
  }
}
