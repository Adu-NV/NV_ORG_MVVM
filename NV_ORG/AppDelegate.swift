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
    var window: UIWindow?
    var navigatinController = UINavigationController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let homeView =  storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //        self.window?.rootViewController = homeView
                if #available(iOS 13.0, *) {
                    UIApplication.shared.statusBarStyle = .lightContent
                    navigatinController = UINavigationController(rootViewController: homeView)
                    navigatinController.isNavigationBarHidden = true
                    self.window?.rootViewController = navigatinController
                    self.window?.makeKeyAndVisible()
                }else{
                    self.window?.rootViewController = homeView
                }
        return true
    }
    
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = self.window?.rootViewController
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

