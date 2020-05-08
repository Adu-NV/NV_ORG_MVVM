//
//  NotificationsViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 04/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class NotificationsViewModel {
    var numberofSections : Int {
         return  1
     }
    var numberofRows : Int = 0
    func numberOfRowsInSection(_ section : Int ,_ tag : Int) -> Int{
        return numberofRows
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
}
