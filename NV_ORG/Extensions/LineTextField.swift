//
//  LineTextField.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LineTextField: UITextField {
    @IBInspectable var lineWidth:CGFloat = 1 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineColor:UIColor = UIColor.black {
        didSet{
            setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        context?.setLineWidth(lineWidth)
        context?.beginPath()
        context?.move(to: CGPoint(x: -1, y: rect.height - lineWidth))
        context?.addLine(to: CGPoint(x: rect.width , y: rect.height - lineWidth))
        context?.setStrokeColor(lineColor.cgColor)
        context?.strokePath()
    }

}

