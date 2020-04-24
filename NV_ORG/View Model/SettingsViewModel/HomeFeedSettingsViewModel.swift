//
//  HomeFeedSettingsViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class HomeFeedSettingsViewModel{
    var dashBoardModel : DashBoardResponseModel!
    public var delegate :HomeFeedSettingsViewControllerDelegateProtocol?
    var menuItems : [Bool] = [true,true,true,true,true,true,true,true]
    let homeFeedItems : [String] = ["Events","News","Gallery","Celebrations","Meetings","Jobs","Advertisement","Chat"]
    var numberofSections : Int {
         return  1
     }
    
    func numberOfRowsInSection(_ section : Int) -> Int{
        return homeFeedItems.count
     }
    
    func HomeAtIndex(_ index : Int) -> HomeFeedItems{
        let menu = self.homeFeedItems[index]
        return HomeFeedItems(menu)
    }
    
    func SwitchAtIndex(_ index : Int) -> Bool{
        return menuItems[index]
    }
}
extension HomeFeedSettingsViewModel: HomeFeedSettingsViewModelDelegateProtocol{
    func setdashBoardFeedModel(model: DashBoardResponseModel) {
        self.dashBoardModel = model
        setDashBoard()
    }
    
    func setDashBoard(){
        self.menuItems[0] = (self.dashBoardModel.data?.is_events)!
        self.menuItems[1] = (self.dashBoardModel.data?.is_news)!
        self.menuItems[2] = (self.dashBoardModel.data?.is_gallery)!
        self.menuItems[3] = (self.dashBoardModel.data?.is_celebrating)!
        self.menuItems[4] = (self.dashBoardModel.data?.is_meetings)!
        self.menuItems[5] = (self.dashBoardModel.data?.is_job_vacancy)!
        self.menuItems[6] = (self.dashBoardModel.data?.is_advertisment)!
        self.menuItems[7] = (self.dashBoardModel.data?.is_chat)!
    }
    
    func skipButtontapped(view: UIViewController) {
                        if #available(iOS 13.0, *) {
            if let navController = view.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            view.dismiss(animated: false, completion: nil)
        }
    }
}

struct HomeFeedItems{
    var titles : String?
    var switchBool : Bool?
}

extension HomeFeedItems{
    var title : String{
        return self.titles!
    }
    var boolValue : Bool{
        return self.switchBool!
    }
}

extension HomeFeedItems{
    init(_ article : String) {
        self.titles = article
    }
}
