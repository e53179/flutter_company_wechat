import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return self.handleOpenURL(url, sourceApplication: nil)
    }
    
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return self.handleOpenURL(url, sourceApplication: sourceApplication)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return self.handleOpenURL(url, sourceApplication: nil)
    }
    
    
    func handleOpenURL(_ url: URL, sourceApplication: String?) -> Bool {
        return WWKApi.handleOpen(url, delegate: self)
    }
}

extension AppDelegate: WWKApiDelegate {
    
    func onResp(_ resp: WWKBaseResp!) {
        var result: [String: Any] = [:]
        
        if resp.isKind(of: WWKSSOResp.self) {
            let r: WWKSSOResp = resp as! WWKSSOResp
            result["code"] = r.code
            result["state"] = r.state
        }
        
        result["errCode"] = resp.errCode
        result["errStr"] = resp.errStr
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "KNotificationWWKOOS"), object: nil, userInfo: result)
    }
}


