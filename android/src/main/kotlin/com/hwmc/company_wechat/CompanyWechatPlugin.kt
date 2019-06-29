package com.yczbj.company_wechat

import android.app.Activity
import com.tencent.wework.api.IWWAPI
import com.tencent.wework.api.IWWAPIEventHandler
import com.tencent.wework.api.model.BaseMessage
import com.tencent.wework.api.model.WWAuthMessage
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONObject


class CompanyWechatPlugin : MethodCallHandler {
    var activity: Activity? = null

    constructor(activity: Activity) {
        this.activity = activity
    }


    companion object {

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "company_wechat")
            channel.setMethodCallHandler(CompanyWechatPlugin(registrar.activity()))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "companyWechatLogin") {
            val schema = call.argument<String>("schema")
            val appId = call.argument<String>("appId")
            val agentId = call.argument<String>("agentId")
            val iwwapi: IWWAPI = com.tencent.wework.api.WWAPIFactory.createWWAPI(activity?.applicationContext)
            iwwapi.registerApp(schema)
            val req = WWAuthMessage.Req()
            req.sch = schema
            req.appId = appId
            req.agentId = agentId
            req.state = "dd"
            iwwapi.sendMessage(req) { resp ->
                if (resp is WWAuthMessage.Resp) {
                    val rsp = resp as WWAuthMessage.Resp
                    var jsonObject = HashMap<String,Any>()
                    jsonObject.put("errCode",rsp.errCode)
                    jsonObject.put("code",rsp.code)
                    jsonObject.put("platform","android")
                    result.success(jsonObject)
                }
            }


        } else {
            result.notImplemented()
        }
    }
}
