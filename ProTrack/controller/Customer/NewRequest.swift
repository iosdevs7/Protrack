    //
    //  NewRequest.swift
    //  ProTrack
    //
    //  Created by Sunny on 25/09/14.
    //  Copyright (c) 2014 IBM. All rights reserved.
    //
    
import UIKit
import CoreData
import MapKit
import CoreLocation
protocol datatransferedDelegate{
        func didUserInformation(info:NSString, date:NSString , time: NSString)
    }
    
class NewRequest: BaseViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate{
        
        var myLatitude:CLLocationDegrees = CLLocationDegrees()
        var myLongitude:CLLocationDegrees = CLLocationDegrees()
        var mySelectedArea = ["Nagwara","BTM","Kormangla","Banerghatta"]
        
        @IBOutlet var myAreaTable: UITableView!
        @IBOutlet var lblTime: UILabel!
        @IBOutlet var lblDate: UILabel!
        @IBOutlet var error:UILabel!
        
        
        @IBOutlet var reqDesp: UITextField!
        @IBOutlet var street:UITextField!
        @IBOutlet var area:UITextField!
        @IBOutlet var city:UITextField!
        
        //Snapshots of New Request
        @IBOutlet weak var myImageView1: UIImageView!
        @IBOutlet weak var myImageView2: UIImageView!
        @IBOutlet weak var myImageView3: UIImageView!
        
        var delegate:datatransferedDelegate? = nil
        var myselectedImageView: UIImageView = UIImageView()
        var myReqId:String = String()
        
        //Tap Gesture
        let tapRec1 = UITapGestureRecognizer()
        let tapRec2 = UITapGestureRecognizer()
        let tapRec3 = UITapGestureRecognizer()
        
        var flag:Int = 0
        //Getting Current Date and time
        
        
        @IBAction func reqDesp2(sender: AnyObject) {
            if(countElements(reqDesp.text) >= 25)
            {
                reqDesp.endEditing(true)
            }
        }
        
        @IBAction func street1(sender: AnyObject) {
            if(countElements(street.text) >= 15)
            {
                street.endEditing(true)
            }
            
        }
        
        @IBAction func city1(sender: AnyObject) {
            if(countElements(city.text) >= 15)
            {
                city.endEditing(true)
            }
        }
        
        func getCurrentDateAndTime()->(d:String,t:String)
        {
            var dateAndTime:NSDate = NSDate()
            var dateFormatter:NSDateFormatter = NSDateFormatter()
            var dateFormatter1:NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter1.dateFormat = "HH:mm"
            var date1 :String = dateFormatter.stringFromDate(dateAndTime)
            var time1 :String = dateFormatter1.stringFromDate(dateAndTime)
            return (date1,time1)
        }
        
        //UIImagePicker View For selection image
        func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
        {
            if(flag==0)
            {
                if(myImageView1.image == UIImage(named: "noimage.png"))
                {
                 
                    let chosenImage:AnyObject?=info[UIImagePickerControllerEditedImage]
                    self.myImageView1.image = chosenImage as? UIImage
                    picker.dismissViewControllerAnimated(true ,completion: nil)
                }
                else if(myImageView2.image == UIImage(named: "noimage.png"))
                {
                    let chosenImage:AnyObject?=info[UIImagePickerControllerEditedImage]
                    self.myImageView2.image = chosenImage as? UIImage
                    picker.dismissViewControllerAnimated(true ,completion: nil)
                }
                else if(myImageView3.image == UIImage(named: "noimage.png"))
                {
                    let chosenImage:AnyObject?=info[UIImagePickerControllerEditedImage]
                    self.myImageView3.image = chosenImage as? UIImage
                    picker.dismissViewControllerAnimated(true ,completion: nil)
                }
            }
            else if(flag == 1){
                if(myImageView1.image != UIImage(named: "noimage.png"))
                {
                    
                    let chosenImage:AnyObject?=info[UIImagePickerControllerEditedImage]
                    self.myImageView1.image = chosenImage as? UIImage
                    picker.dismissViewControllerAnimated(true ,completion: nil)
                    flag = 0
                }
                else if(myImageView2.image != UIImage(named: "noimage.png"))
                {
                    let chosenImage:AnyObject?=info[UIImagePickerControllerEditedImage]
                    self.myImageView2.image = chosenImage as? UIImage
                    picker.dismissViewControllerAnimated(true ,completion: nil)
                    flag = 0
                }
                else if(myImageView3.image != UIImage(named: "noimage.png"))
                {
                    let chosenImage:AnyObject?=info[UIImagePickerControllerEditedImage]
                    self.myImageView3.image = chosenImage as? UIImage
                    picker.dismissViewControllerAnimated(true ,completion: nil)
                    flag = 0
                }
                
            }
            
        }
        
        //On clicking Raise Request Button
        @IBAction func resSubmit()
        {
            if(reqDesp.text == "" || street.text == "" || area.text == "" || city.text == "")
            {
                error.hidden = false
                error.text="*Enter All Fields"
            }
            else
            {
                
                error.hidden = true
                let dateTime = getCurrentDateAndTime()
                
                //Reference to app delegate
                let appDel:AppDelegate=(UIApplication.sharedApplication().delegate as AppDelegate)
                
                //Reference to managed object
                let context:NSManagedObjectContext = appDel.managedObjectContext!
                
                //Enity Description
                let taskEntity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)
                
                //Object of Entity Task
                var task = Task (entity:taskEntity!, insertIntoManagedObjectContext: context)
                
                let addressEntity = NSEntityDescription.entityForName("Address", inManagedObjectContext: context)
                var address = Address (entity:addressEntity!, insertIntoManagedObjectContext: context)
                
                task.date = dateTime.d
                task.desp = reqDesp.text
                task.reqId = "Req"+String(arc4random()%10000)
                task.status = "Open"
                task.time = dateTime.t
                task.address = address
                
                if(area.text == "Nagwara")
                {
                    task.address.latitude = 13.0448805
                    task.address.longitude = 77.6085027
                }
                    
                    
                else if(area.text == "BTM")
                {
                    task.address.latitude = 12.9200
                    task.address.longitude = 77.6100
                }
                    
                else if(area.text == "Kormangla")
                {
                    task.address.latitude = 12.9259
                    task.address.longitude = 77.6229
                }
                    
                else if(area.text == "Banerghatta")
                {
                    task.address.latitude = 12.8008
                    task.address.longitude = 77.5756
                }
                address.area = area.text
                address.city = city.text
                address.street = street.text
                
                
                
                let imageEntity = NSEntityDescription.entityForName("Image", inManagedObjectContext: context)
                
                var imageObj = Image (entity:imageEntity!, insertIntoManagedObjectContext: context)
                var imageObj1 = Image (entity:imageEntity!, insertIntoManagedObjectContext: context)
                var imageObj2 = Image (entity:imageEntity!, insertIntoManagedObjectContext: context)
                
                
                
                var imageSet: NSSet = NSSet(objects: imageObj,imageObj1,imageObj2)
                task.image = imageSet
                
                for var i=0;i<3;i++
                {
                    
                    if(i==0)
                    {
                        if(myImageView1.image != UIImage(named: "noimage.png"))
                        {
                            imageObj.image = UIImagePNGRepresentation(myImageView1.image)
                            imageObj.task = task
                            
                        }
                        
                    }
                    if(i==1)
                    {
                        if(myImageView2.image != UIImage(named: "noimage.png") && myImageView1.image != UIImage(named: "noimage.png"))
                        {
                            imageObj1.image = UIImagePNGRepresentation(myImageView2.image)
                            imageObj1.task = task
                            
                        }
                    }
                    if(i==2)
                    {
                        if(myImageView3.image != UIImage(named: "noimage.png"))
                        {
                            
                            imageObj2.image = UIImagePNGRepresentation(myImageView3.image)
                            imageObj2.task = task
                            
                        }
                    }
                }
                
                context.save(nil)
                
                if (delegate != nil)
                {
                    
                    myReqId = task.reqId
                    delegate!.didUserInformation(myReqId,date: dateTime.d,time: dateTime.t)
                    navigationController?.popViewControllerAnimated(true)
                }
            }
        }
        
        //UIImagePincker View action done when pressed cancel button
        func imagePickerControllerDidCancel(picker: UIImagePickerController)
        {
               picker.dismissViewControllerAnimated(true , completion: nil)
        }
        
        //Action Sheet for UIIMagePickerView
        @IBAction func selectPhoto(sender: AnyObject)
        {
            selectPhoto()
        }
        func selectPhoto() {
            
            var sheet:UIActionSheet = UIActionSheet();
            let title:String = "Choose image";
            sheet.title = title
            sheet.delegate = self
            sheet.tag = 1
            sheet.addButtonWithTitle("Cancel")
            sheet.addButtonWithTitle("Camera")
            sheet.addButtonWithTitle("Gallery")
            sheet.cancelButtonIndex=0;
            sheet.showInView(self.view)
        }
        
        //Action Sheet choosing index
        func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
        {
            
            if(actionSheet.tag==1)
            {
                if(buttonIndex==2)
                {
                    
                    album()
                    actionSheet.dismissWithClickedButtonIndex(1, animated: true )            }
                    
                else if(buttonIndex==1)
                {
                    camera()
                }
            }
            if(actionSheet.tag==2)
            {
                if(buttonIndex==1)
                {
                    
                    actionSheet.dismissWithClickedButtonIndex(1, animated: true )
                    flag = 1
                    //actionSheet.tag=1
                    selectPhoto()
                    
                }
                else if(buttonIndex==2)
                {
                    NSLog("Delete Pic")
                    myselectedImageView.image = UIImage(named: "noimage.png")
                    
                }
                
                
            }
        }
        
        
        
        //Camera
        func camera()
        {
            if(UIImagePickerController.isSourceTypeAvailable(.Camera))
            {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing=true
                picker.sourceType=UIImagePickerControllerSourceType.Camera
                self.presentViewController(picker,animated:true,completion: nil)
            }
            else
            {
                println("Camera Not Availble")
            }
        }
        
        //Choose from Gallery
        func album()
        {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing=true
            picker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(picker,animated:true,completion: nil)
        }
        
        func longPressedView(sender: UILongPressGestureRecognizer)
        {
            self.myselectedImageView = sender.view as UIImageView
            
            if(myselectedImageView != UIImage(named: "noimage.png"))
            {
                if sender.state == UIGestureRecognizerState.Ended {
                    var sheet1:UIActionSheet = UIActionSheet();
                    sheet1.tag=2
                    let title:String = "Image edit options";
                    sheet1.title = title;
                    sheet1.delegate = self
                    sheet1.addButtonWithTitle("Cancel")
                    sheet1.addButtonWithTitle("Change Photo")
                    sheet1.addButtonWithTitle("Delete Photo")
                    sheet1.cancelButtonIndex=0;
                    sheet1.showInView(self.view)
                    
                    
                }
            }
            else
            {
                println("No image")
            }
        }
        
        func tappedView(sender:UIGestureRecognizer)
        {
            dispatch_async(dispatch_get_main_queue() ) {
                
                let selectedImageView: UIImageView = sender.view as UIImageView
                
                
                if ( selectedImageView == self.myImageView1 && !(self.myImageView1.image == UIImage(named: "noimage.png")))
                    
                {
                    var zoomImage:ZoomImage = self.storyboard?.instantiateViewControllerWithIdentifier("ZoomImage") as ZoomImage
                    zoomImage.image = self.myImageView1.image!
                    self.presentViewController(zoomImage, animated: true, completion: nil)
                }
                
                if( selectedImageView == self.myImageView2 && !(self.myImageView2.image == UIImage(named: "noimage.png")))
                {
                    var zoomImage:ZoomImage = self.storyboard?.instantiateViewControllerWithIdentifier("ZoomImage") as ZoomImage
                    zoomImage.image = self.myImageView2.image!
                    self.presentViewController(zoomImage, animated: true, completion: nil)
                    
                }
                if( selectedImageView == self.myImageView3 && !(self.myImageView3.image == UIImage(named: "noimage.png")))
                {
                    var zoomImage:ZoomImage = self.storyboard?.instantiateViewControllerWithIdentifier("ZoomImage") as ZoomImage
                    zoomImage.image = self.myImageView3.image!
                    self.presentViewController(zoomImage, animated: true, completion: nil)
                }
                
            }
            
            
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "New Request"
            
            reqDesp.becomeFirstResponder()
            let longPressRec:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedView:")
            
            // longPressRec.minimumPressDuration=2;
            myImageView1.addGestureRecognizer(longPressRec)
            
            let longPressRec1:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedView:")
            
            // longPressRec.minimumPressDuration=2;
            myImageView2.addGestureRecognizer(longPressRec1)
            
            
            let longPressRec2:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressedView:")
            
            // longPressRec.minimumPressDuration=2;
            myImageView3.addGestureRecognizer(longPressRec2)
            
            
            
            //Tapgesture
            tapRec1.addTarget(self, action:"tappedView:" )
            
            myImageView1.addGestureRecognizer(tapRec1)
            myImageView1.userInteractionEnabled=true
            
            
            tapRec2.addTarget(self, action: "tappedView:")
            
            myImageView2.addGestureRecognizer(tapRec2)
            myImageView2.userInteractionEnabled=true
            
            
            
            tapRec3.addTarget(self, action: "tappedView:")
            myImageView3.addGestureRecognizer(tapRec3)
            myImageView3.userInteractionEnabled=true
            
            let dateTime = getCurrentDateAndTime()
            lblTime.text = "Time:"+dateTime.t
            lblDate.text = "Date:"+dateTime.d
            reqDesp.delegate = self
            street.delegate = self
            city.delegate = self
        }
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func button(sender: UIButton) {
            
        }
        @IBAction func myArea(sender: AnyObject)
        {
            myAreaTable.hidden = false
        }
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;
        }
        
        func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
            return mySelectedArea.count
        }
        func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
            var myTechCell = tableView.dequeueReusableCellWithIdentifier("celll") as UITableViewCell!
            
            if !(myTechCell != nil)
            {
                
                myTechCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celll")
            }
            myTechCell.textLabel?.font = UIFont.systemFontOfSize(15.0)
            
            myTechCell.textLabel?.alignmentRectInsets()
            
            myTechCell.textLabel?.text = self.mySelectedArea[indexPath.row]
        
            return myTechCell
            
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            
            var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            area.text = selectedCell.textLabel?.text
            myAreaTable.hidden = true
            
            
            
        }
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            return true
        }
        override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
            
            
            reqDesp.resignFirstResponder()
            
            street.resignFirstResponder()
            city.resignFirstResponder()
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
