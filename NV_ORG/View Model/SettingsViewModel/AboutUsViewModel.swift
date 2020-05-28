//
//  AboutUsViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class AboutUsViewModel{
    var numberofSections : Int {
         return  1
     }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return 1
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
}

extension AboutUsViewModel: AboutViewModelDelegateProtocol{
    func skipButtontapped(view: UIViewController) {
          view.dismiss(animated: false, completion: nil)
    }
    
    
}
