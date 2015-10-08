//
//  RequestDescription.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class RequestDescription: UIViewController {
    var str:String = String()
    var firstImage:UIImage = UIImage()
    var secondImage:UIImage = UIImage()
    var thirdImage:UIImage = UIImage()
    
    let tapRec1 = UITapGestureRecognizer()
    let tapRec2 = UITapGestureRecognizer()
    let tapRec3 = UITapGestureRecognizer()
    
    @IBOutlet var myCommnets: UITextField!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblReq: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.myView.layer.borderColor = UIColor.blackColor().CGColor
        self.myView.layer.borderWidth = 2
        self.myView.layer.cornerRadius = 6
        
        self.title = "Request Description"
        
        lblReq.text = str
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request1=NSFetchRequest(entityName: "Task")
        
        request1.predicate = NSPredicate(format:"reqId = %@", str)
        request1.returnsObjectsAsFaults = false
        var result1: NSArray! = context.executeFetchRequest(request1, error: nil)
        
        
        
        if(result1.count > 0)
        {
            let task: Task = result1.firstObject as Task
    
            lblDescription.text =  task.desp
            lblStatus.text = task.status
            lblDate.text = task.date
            lblTime.text = task.time
            lblStreet.text = task.address.street
            lblArea.text = task.address.area
            lblCity.text = task.address.city
            lblDescription.numberOfLines = 2
            lblDescription.preferredMaxLayoutWidth = 70
            lblDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblDescription.sizeToFit()
            let imageSet = task.image
            
            
            
        }
        
        var request = NSFetchRequest(entityName:"Login")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format:"role =%@","customer")
        
        var result:NSArray! = context.executeFetchRequest(request,error: nil)
        if(result.count > 0)
        {
            
            let res: Login = result.firstObject as Login
            lblName.text =  res.name
        }
        
        
        image1.image = firstImage
        image2.image = secondImage
        image3.image = thirdImage
        
        
        
        tapRec1.addTarget(self, action:"tappedView:" )
        
        image1.addGestureRecognizer(tapRec1)
        image1.userInteractionEnabled=true
        
        
        tapRec2.addTarget(self, action: "tappedView:")
        
        image2.addGestureRecognizer(tapRec2)
        image2.userInteractionEnabled=true
        
        
        
        tapRec3.addTarget(self, action: "tappedView:")
        image3.addGestureRecognizer(tapRec3)
        image3.userInteractionEnabled=true
        
    }
    
    func tappedView(sender:UIGestureRecognizer)
    {
        dispatch_async(dispatch_get_main_queue() ) {
            
            let selectedImageView: UIImageView = sender.view as UIImageView
            
            
            if ( selectedImageView == self.image1 && !(self.image1.image == UIImage(named: "noimage.png")))
                
            {
                var zoomImage:DetailZoomView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailZoomImage") as DetailZoomView
                zoomImage.image = self.image1.image!
                self.presentViewController(zoomImage, animated: true, completion: nil)
            }
            
            if( selectedImageView == self.image2 && !(self.image2.image == UIImage(named: "noimage.png")))
            {
                var zoomImage:DetailZoomView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailZoomImage") as DetailZoomView
                zoomImage.image = self.image2.image!
                self.presentViewController(zoomImage, animated: true, completion: nil)
                
            }
            if( selectedImageView == self.image3 && !(self.image3.image == UIImage(named: "noimage.png")))
            {
                var zoomImage:DetailZoomView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailZoomImage") as DetailZoomView
                zoomImage.image = self.image3.image!
                self.presentViewController(zoomImage, animated: true, completion: nil)
            }
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}

