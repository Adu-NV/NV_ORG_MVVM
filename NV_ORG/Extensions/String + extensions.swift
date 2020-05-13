//
//  String + extensions.swift
//  NV_ORG
//
//  Created by Netventure on 13/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
extension String {

    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
