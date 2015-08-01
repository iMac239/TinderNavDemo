//
//  LFTPulseAnimation.swift
//
//  Created by Christoffer Tews on 18.12.14.
//  Copyright (c) 2014 Christoffer Tews. All rights reserved.
//
//  Swift clone of: https://github.com/shu223/PulsingHalo/blob/master/PulsingHalo/PulsingHaloLayer.m

import UIKit

class PulseLayer: CALayer {
    
    var fromValueForRadius:     CGFloat = 0.0
    var fromValueForAlpha:      CGFloat = 0.45
    var keyTimeForHalfOpacity:  CGFloat = 0.2
    var animationDuration:      NSTimeInterval = 3.0
    var pulseInterval:          NSTimeInterval = 0
    var useTimingFunction:      Bool = true
    var animationGroup:         CAAnimationGroup = CAAnimationGroup()
    var repetitions:            CGFloat = CGFloat.infinity
    var radius:                 CGFloat = 400 {
        didSet {
            frame = CGRect(origin: position, size: CGSize(width: radius * 2, height: radius * 2))
            cornerRadius = radius
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    override func layoutSublayers() {
        super.layoutSublayers()
    }
    
    
    override init() {
        super.init()
        
        opacity = 0.0
        contentsScale = UIScreen.mainScreen().scale
        backgroundColor = UIColor.blueColor().CGColor
        borderColor = UIColor.cyanColor().CGColor
        borderWidth = 4
        repetitions = CGFloat.infinity;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            self.setupAnimationGroup()
            
            if (self.pulseInterval != Double.infinity) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.addAnimation(self.animationGroup, forKey: "pulse")
                }
            }
        }
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = self.animationDuration + self.pulseInterval
        self.animationGroup.repeatCount = Float(repetitions)
        self.animationGroup.removedOnCompletion = false
        
        if self.useTimingFunction {
            let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.animationGroup.timingFunction = defaultCurve
        }
        
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(float: Float(fromValueForRadius))
        scaleAnimation.toValue = NSNumber(float: 1.0)
        scaleAnimation.duration = self.animationDuration
        
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = self.animationDuration
        opacityAnimation.values = [self.fromValueForAlpha, 0.8, 0]
        opacityAnimation.keyTimes = [0, self.keyTimeForHalfOpacity, 1]
        opacityAnimation.removedOnCompletion = false
        
        return opacityAnimation
    }
    
}
