package com.hwmc.company_wechat_example

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.view.FlutterMain

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    FlutterMain.startInitialization(this)
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}
