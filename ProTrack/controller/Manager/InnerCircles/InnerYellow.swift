//
//  InnerYellow.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

    import UIKit
    
    class InnerYellow: UIView {
        
        convenience init(x:Int, y:Int, width:Int , height:Int) {
            
            self.init(frame: CGRect(x: x, y: y, width: width, height: height));
            // self.backgroundColor = UIColor.redColor()
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
            
            let yellowCenter = CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
            
            let smallRadius = CGFloat(CGFloat(self.frame.size.width)/10)
            CGContextSetStrokeColorWithColor(innerContext, UIColor.yellowColor().CGColor)
            
            CGContextSetLineWidth(innerContext, 25.0)
            
            startAngle = startAngle - Float(M_PI)
            endAngle = endAngle - Float(M_PI_2)
            
            
            
            CGContextAddArc(innerContext, yellowCenter.x, yellowCenter.y, CGFloat(smallRadius), CGFloat(startAngle), CGFloat(endAngle), 1)
            CGContextStrokePath(innerContext)
            
            
        }
        
        
    }





