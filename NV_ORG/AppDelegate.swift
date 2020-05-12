//
//  AppDelegate.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import ReachabilitySwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var navigatinController = UINavigationController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//         checkNetworkRechability()
        if let _ = UserDefaults.standard.value(forKey: "token"){
            homeScreen()
        }else{
            loginScreen()
        }
        return true
    }
    
    func homeScreen(){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            /GalleryViewController
//            let homeView =  storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
//            homeView.setUPViewController()
            
            let homeView =  storyboard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                       homeView.setUPViewController()
            if #available(iOS 13.0, *) {
                UIApplication.shared.statusBarStyle = .lightContent
                self.navigatinController = UINavigationController(rootViewController: homeView)
                self.navigatinController.isNavigationBarHidden = true
                self.window?.rootViewController = self.navigatinController
//                self.window?.makeKeyAndVisible()
            }else{
                self.window?.rootViewController = homeView
            }
        }
        
    }
    func loginScreen(){
        DispatchQueue.main.async {
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let homeView =  storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if #available(iOS 13.0, *) {
                UIApplication.shared.statusBarStyle = .lightContent
                self.navigatinController = UINavigationController(rootViewController: homeView)
                self.navigatinController.isNavigationBarHidden = true
                self.window?.rootViewController = self.navigatinController
                self.window?.makeKeyAndVisible()
            }else{
                self.window?.rootViewController = homeView
            }
        }

    }
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController?
        if #available(iOS 13.0, *){
            topVC  = (self.window?.rootViewController as! UINavigationController).children[0]
        }else{
            topVC  = self.window?.rootViewController
        }
        
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    
    func checkNetworkRechability() {
        do {
            Network.reachability = try ReachabilityManager(hostname: "www.google.com")
            try Network.reachability?.start()
            NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        } catch {
            print(error)
        }
    }
    
    func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            AlertBar.show(type: .warning, message: "Offline", duration: 10)
            self.showNoWifiView()
        case .wifi:
            AlertBar.show(type: .success, message: "Online", duration: 5)
            AlertBar.hide()
            self.homeScreen()
        case .wwan:
            AlertBar.show(type: .success, message: "Online", duration: 5)
            self.homeScreen()
        }
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }

    
    func showNoWifiView(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nowifi =  storyboard.instantiateViewController(withIdentifier: "NoInternetViewController") as! NoInternetViewController
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                           UIApplication.shared.statusBarStyle = .lightContent
                           self.navigatinController = UINavigationController(rootViewController: nowifi)
                           self.navigatinController.isNavigationBarHidden = true
                           self.window?.rootViewController = self.navigatinController
                           self.window?.makeKeyAndVisible()
                       }else{
                           self.window?.rootViewController = nowifi
                       }
            
        }
    }
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension UIWindow {
    /// Returns the currently visible view controller if any reachable within the window.
    public var visibleViewController: UIViewController? {
        return UIWindow.visibleViewController(from: rootViewController)
    }

    /// Recursively follows navigation controllers, tab bar controllers and modal presented view controllers starting
    /// from the given view controller to find the currently visible view controller.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to start the recursive search from.
    /// - Returns: The view controller that is most probably visible on screen right now.
    public static func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
        switch viewController {
        case let navigationController as UINavigationController:
            return UIWindow.visibleViewController(from: navigationController.visibleViewController ?? navigationController.topViewController)

        case let tabBarController as UITabBarController:
            return UIWindow.visibleViewController(from: tabBarController.selectedViewController)

        case let presentingViewController where viewController?.presentedViewController != nil:
            return UIWindow.visibleViewController(from: presentingViewController?.presentedViewController)

        default:
            return viewController
        }
    }
}
