//
//  ZoomImage.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class ZoomImage: UIViewController {
    @IBOutlet weak var myZoomedImage: UIImageView!
    
    var image : UIImage = UIImage()
    
    @IBAction func myZoomImage(sender: UIPinchGestureRecognizer) {
        
        
        sender.view!.transform =
            CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1
        
    }
    @IBAction func zoomBack(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myZoomedImage.image = image        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
