//
//  InnerWhite.swift
//  ProTrack
//
//  Created by Sunny on 07/10/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class InnerWhite: UIView {
    let whiteCenter:CGPoint = CGPoint()
    
    convenience init(x:Int, y:Int, width:Int , height:Int) {
        
        self.init(frame: CGRect(x: x, y: y, width: width, height: height));
        // self.backgroundColor = UIColor.whiteColor()
        self.setNeedsDisplay();
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        
        
        
        var startAngle: Float = 360.0
        var endAngle: Float = 0.0
        
        var innerContext = UIGraphicsGetCurrentContext()
        
        let whiteCenter = CGPointMake(self.frame.size.width/2,self.frame.size.height/2 )
        
        
        let smallRadius = CGFloat(CGFloat(self.frame.size.width)/10)
        CGContextSetStrokeColorWithColor(innerContext, UIColor.whiteColor().CGColor)
        
        CGContextSetLineWidth(innerContext, 25.0)
        
        startAngle = startAngle - Float(M_PI)
        endAngle = endAngle - Float(M_PI_2)
        
        
        
        CGContextAddArc(innerContext, whiteCenter.x, whiteCenter.y, CGFloat(smallRadius), CGFloat(startAngle), CGFloat(endAngle), 1)
        
        CGContextStrokePath(innerContext)
        
        
    }
    
    
}
