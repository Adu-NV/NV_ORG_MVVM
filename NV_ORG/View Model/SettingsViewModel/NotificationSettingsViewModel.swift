//
//  NotificationSettingsViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class NotificationSettingsViewModel{
    let notificationItems : [String] = ["Push Notification","Local Notification"]
    var numberofSections : Int {
        return  1
    }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return notificationItems.count
    }
    func NotificationAtIndex(_ index : Int) -> String{
        return self.notificationItems[index]
    }
}

extension NotificationSettingsViewModel: NotificationSettingsViewModelDelegateProtocol{
    func skipButtontapped(view: UIViewController) {
        view.dismiss(animated: false, completion: nil)
    }
}
