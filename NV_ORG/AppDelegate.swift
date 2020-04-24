//
//  AppDelegate.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var navigatinController = UINavigationController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
            let homeView =  storyboard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
            homeView.setUPViewController()
            //        self.window?.rootViewController = homeView
            
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

