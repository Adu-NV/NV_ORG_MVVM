//
//  DirectoryViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 03/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class DirectoryViewModel{
    var numberofSections : Int {
         return  1
     }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return 2
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
}
