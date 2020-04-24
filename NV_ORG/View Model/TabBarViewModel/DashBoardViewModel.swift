//
//  DashBoardViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 30/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
struct DashBoardViewModel{
    
    public var delegate : DashBoardViewModelViewControllerDelegateProtocol?
     let main =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    public var mainCell: [String] = [String]()
    public var request :  DashBoardFeedRequestModel?
    public var dashBoardFeedModel : DashBoardFeedResponseModel?

}

extension DashBoardViewModel : DashBoardViewModelDelegateProtocol{
    
     mutating func setDashBoardCell(model: DashBoardResponseData) {
        if model.is_news!{
            self.mainCell.append("DashBoardTableViewCell0")
        }
        if model.is_events!{
            self.mainCell.append("DashBoardTableViewCell1")
        }
        if model.is_meetings!{
            self.mainCell.append("DashBoardTableViewCell2")
        }
        if model.is_celebrating!{
            self.mainCell.append("DashBoardTableViewCell3")
        }
        if model.is_job_vacancy!{
            self.mainCell.append("DashBoardTableViewCell4")
        }
        if model.is_gallery!{
            self.mainCell.append("DashBoardTableViewCell5")
        }
        if model.is_advertisment!{
            self.mainCell.append("DashBoardTableViewCell6")
        }
        
        request = DashBoardFeedRequestModel(dashBoard: model)
    }
    
    func moveToMenuPage(viewController: UIViewController ,model : DashBoardResponseModel?) {
        main.model = model
        viewController.view.addSubview(main.view)
        main.didMove(toParent: viewController)
    }
    
    func skipButtontapped(view: UIViewController) {
        debugPrint(view)
        main.view.removeFromSuperview()
    }
    
    var numberofSections : Int {
         return  1
     }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return self.mainCell.count
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }

}
