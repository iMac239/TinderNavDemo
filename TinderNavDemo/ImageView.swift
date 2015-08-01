//
//  PulsatingImageView.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/15/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class ImageView: UIImageView {
    let pulseLayer: PulseLayer = PulseLayer()
    let arc = CAShapeLayer()
    let mask = CAShapeLayer()
    var path: UIBezierPath {
        return UIBezierPath(ovalInRect: bounds)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        arc.fillColor = nil
        arc.lineWidth = 4
        arc.strokeColor = UIColor.whiteColor().CGColor
        
        layer.mask = mask
        layer.addSublayer(arc)
        
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        addGestureRecognizer(tap)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        superview?.layer.insertSublayer(pulseLayer, below: layer)
        
    }
    
    func handleTap(gesture: UITapGestureRecognizer) {
        print("tap")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pulseLayer.radius = max(superview?.frame.width ?? 0, superview?.frame.height ?? 0) / 2
        pulseLayer.position = frame.center
        
        arc.path = path.CGPath
        mask.path = path.CGPath
    }
}