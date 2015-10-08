//
//  CustomCircle.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class CustomCircle: UIView {
    var button1   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    var innerView1 = InnerRed()
    
    convenience init(x:Int, y:Int, width:Int , height:Int, title:[String]) {
        
        
        self.init(frame: CGRect(x: x, y: y, width: width, height: height));
        self.backgroundColor = UIColor.clearColor()
        
        let radius = CGFloat((CGFloat(self.frame.size.width)/4)+20)
        
        innerView1 = InnerRed (frame: CGRect(x: center.x-24 ,y: center.y-85, width: radius*1.5, height: radius*1.5));
        self.addSubview(innerView1);
        innerView1.backgroundColor=UIColor.clearColor()
        
        
        button1.frame = CGRectMake(0, 0, 50, 21)
        button1.center = CGPointMake(center.x-12, center.y-35)
        button1.setTitle(title[0], forState: UIControlState.Normal)
        button1.tag = 12
        button1.tintColor = UIColor.blackColor()
        button1.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        innerView1.addSubview(button1)
        
        var innerView2:InnerGreen = InnerGreen(frame: CGRect(x: center.x-10 ,y: center.y-35, width: radius*1.5, height: radius*1.5));
        self.addSubview(innerView2);
        innerView2.backgroundColor=UIColor.clearColor()
        var label2 = UILabel(frame: CGRectMake(0, 0, 50, 21))
        label2.center = CGPointMake(center.x-8, center.y-35)
        label2.text = title[1]
        innerView2.addSubview(label2)
        
        var innerView3:InnerYellow = InnerYellow(frame: CGRect(x: center.x-70 ,y: center.y-20, width: radius*1.5, height: radius*1.5));
        self.addSubview(innerView3);
        innerView3.backgroundColor=UIColor.clearColor()
        var label3 = UILabel(frame: CGRectMake(0, 0, 50, 21))
        label3.center = CGPointMake(center.x-8, center.y-35)
        label3.text = title[2]
        innerView3.addSubview(label3)
        
        
        
        
        var innerView4:InnerWhite = InnerWhite(frame: CGRect(x: center.x-80 ,y: center.y-80, width: radius*1.5, height: radius*1.5));
        self.addSubview(innerView4);
        innerView4.backgroundColor=UIColor.clearColor()
        var label4 = UILabel(frame: CGRectMake(0, 0, 50, 21))
        
        label4.center = CGPointMake(center.x-8, center.y-35)
        label4.text = title[3]
        innerView4.addSubview(label4)
        self.setNeedsDisplay();
        
    }
    
    
     override func drawRect(rect: CGRect)
    {
        var startAngle: Float = 360.0
        var endAngle: Float = 0.0
        
        let radius = CGFloat((CGFloat(self.frame.size.width)/4)+20)
        
        
        // Drawing code
        
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        println("x = \(self.frame.origin.x) and Y = \(self.frame.origin.y)")
        let center = CGPointMake(self.frame.size.width / 2 + self.frame.origin.x, self.frame.size.height / 2 + self.frame.origin.y)
        
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, 2.0)
        
        // Set the fill color (if you are filling the circle)
        
        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
        
        // Rotate the angles so that the inputted angles are intuitive like the clock face: the top is 0 (or 2π), the right is π/2, the bottom is π and the left is 3π/2.
        // In essence, this appears like a unit circle rotated π/2 anti clockwise.
        startAngle = startAngle - Float(M_PI)
        endAngle = endAngle - Float(M_PI_2)
        
        // Draw the arc around the circle
        
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), CGFloat(startAngle), CGFloat(endAngle), 1)
        
        // Draw the arc
        
        CGContextStrokePath(context)
        
    }
    
    
}
