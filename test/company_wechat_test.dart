import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:company_wechat/company_wechat.dart';

void main() {
  const MethodChannel channel = MethodChannel('company_wechat');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await CompanyWechat.platformVersion, '42');
  });
}
