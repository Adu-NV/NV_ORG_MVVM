//
//  LeaderShipViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class LeaderShipViewModel{
    var numberofSections : Int {
         return  1
     }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return 1
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return 90.0//UITableView.automaticDimension
    }
    
}
extension LeaderShipViewModel: LeaderShipViewModelDelegateProtocol{
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
