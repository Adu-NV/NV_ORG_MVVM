//
//  MenuControllerViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import  UIKit

class MenuControllerViewModel{
    var dashModel : DashBoardResponseModel?
    public var delegate : MenuViewControllerDelegateProtocol?
    let main =  UIStoryboard.init(name: "Main", bundle: nil)
    var viewC = UIViewController()
    let menu : [MenuItems] = []
    var menus = [String]()
    let menuItems : [String] = ["Home Feed Settings","Notification Settings","Change Password","Leadership","Privacy","About Us","Logout"]
    var numberofSections : Int {
        return  1
    }
    
    func numberOfRowsInSection(_ section : Int) -> Int{
        if menus.isEmpty{
            return menuItems.count + 1
        }else{
            return menus.count + 1
        }
        
    }
    
    func MenuAtIndex(_ index : Int) -> MenuItems{
        if menus.isEmpty{
            return MenuItems(self.menuItems[index])
        }else{
            return MenuItems(self.menus[index])
        }
    }
    
    init(model : DashBoardResponseModel?) {
        menus.append(contentsOf: menuItems)
//        if model != nil{
//            if (model?.data?.is_news)!{
//                menus.append("News")
//            }
//            if (model?.data?.is_events)!{
//                menus.append("Events")
//            }
//            if (model?.data?.is_meetings)!{
//                menus.append("Meetings")
//            }
//            if (model?.data?.is_celebrating)!{
//                menus.append("Celebrations")
//            }
//            if (model?.data?.is_job_vacancy)!{
//                menus.append("Job Vacancy")
//            }
//            if (model?.data?.is_gallery)!{
//                menus.append("Gallery")
//            }
//            if (model?.data?.is_advertisment)!{
//                menus.append("Advertisement")
//            }
//            menus.append(contentsOf: menuItems)
//        }
//        else{
//            menus.append(contentsOf: menuItems)
//        }
    }
}

extension MenuControllerViewModel: MenuViewModelDelegateProtocol{
    func moveToLogin() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        DispatchQueue.main.async {
            let delegates = (UIApplication.shared.delegate as! AppDelegate)
            delegates.loginScreen()
        }

    }
    
    func moveToPage(from viewController: UIViewController ,index : Int) {
//        if menus[index] == "News"{
//           viewC = main.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
//        }
//        if menus[index] == "Events"{
//           viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
//            return
//        }
//        if menus[index] == "Meetings"{
//           viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
//            return
//        }
//        if menus[index] == "Celebrations"{
//           viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
//            return
//        }
//        if menus[index] == "Job Vacancy"{
//           viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
//            return
//        }
//        if menus[index] == "Gallery"{
//           viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
//            return
//        }
//        if menus[index] == "Advertisement"{
//           viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
//            return
//        }
        
        if menus[index] == "Home Feed Settings"{
            viewC = main.instantiateViewController(withIdentifier: "HomeFeedSettingsViewController") as! HomeFeedSettingsViewController
         }
        if menus[index] == "Notification Settings"{
            viewC = main.instantiateViewController(withIdentifier: "NotificationSettingsViewController") as! NotificationSettingsViewController
        }
        if menus[index] == "Change Password"{
            viewC =  main.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        }
        if menus[index] == "Leadership"{
            viewC = main.instantiateViewController(withIdentifier: "LeaderShipViewController") as! LeaderShipViewController
        }
        if menus[index] == "Privacy"{
            viewC = main.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
         }
        if menus[index] == "About Us"{
            viewC = main.instantiateViewController(withIdentifier: "AboutUSViewController") as! AboutUSViewController
        }
        if menus[index] == "Logout"{
            delegate!.didCallSignOutAPI()
            return
        }
         movedToNextPage(from: viewController)
    }
    
    func movedToNextPage(from viewController : UIViewController){
        if #available(iOS 13.0, *) {
            viewController.navigationController?.pushViewController(viewC, animated: false)
        }else{
            viewController.present(viewC, animated: false, completion: nil)
        }
    }
    
    func skipButtontapped(view: UIViewController) {
        view.removeFromParent()
    }
    
}


extension MenuItems{
    var title : String{
        return self.titles!
    }
}


struct MenuItems{
    var titles : String?
}

extension MenuItems{
    init(_ article : String) {
        self.titles = article
    }
}
