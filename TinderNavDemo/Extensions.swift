//
//  Extensions.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addOptionalSubview(view: UIView?) {
        if let v = view {
            addSubview(v)
        }
    }
}

extension Int {
    var floatValue: CGFloat {
        return CGFloat(self)
    }
}

extension UIColor {
    typealias HSBA = (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)
    
    var components: HSBA {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
    }
}