//
//  AppDelegate.swift
//  Bank316
//
//  Created by Iplexuss Software Solutions on 17/08/23.
//

import UIKit
import StripeCore
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StripeAPI.defaultPublishableKey = "pk_test_51JNCruJlyaU3sS1muFG4MxgavGPpiivECSHJGp62I3EabZWNgmTeL86cuo8wsjZ73ERZhJfJCypW2yJ12N2QaDOX00NlkQmWwc"
                // do any other necessary launch configuration
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        showBlurView()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        hideBlurView()
    }

}


//MARK: - Ui Application for Top View Controller
extension UIApplication{
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
