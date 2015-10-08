//
//  TechnicianHome.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData
import MapKit
class TechnicianHome: BaseViewController,MKMapViewDelegate {
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    var firstImage:UIImage = UIImage()
    var secondImage:UIImage = UIImage()
    var thirdImage:UIImage = UIImage()
    
    let tapRec1 = UITapGestureRecognizer()
    let tapRec2 = UITapGestureRecognizer()
    let tapRec3 = UITapGestureRecognizer()
    
    @IBOutlet var techdespView: UIView!
    @IBOutlet var techCity: UILabel!
    @IBOutlet var techStreet: UILabel!
    @IBOutlet var myTechTable: UITableView!
    @IBOutlet var techDesp: UILabel!
    @IBOutlet var techStatus: UILabel!
    @IBOutlet var techPriority: UILabel!
    
    var techName:String = String()
    var techTasks:NSArray!
    var currentStatus:Task!
    var currentIndexPath: NSIndexPath!
    var lat:CLLocationDegrees = CLLocationDegrees()
    var long:CLLocationDegrees = CLLocationDegrees()
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController2: NSFetchedResultsController = NSFetchedResultsController()
    
    var rowCount: Int = Int()

    
    @IBAction func techLogOut(sender: AnyObject){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func Accept(sender: AnyObject) {
    }
    
    @IBAction func decline(sender: AnyObject) {
    }
    
    
    func taskFetchRequest()->NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:false)
        fetchRequest.sortDescriptors=[sortDescriptor]
        return fetchRequest
        
    }
    
    func getFetchedResultController()->NSFetchedResultsController
    {
        fetchedResultController2 = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController2
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        myTechTable.layer.borderColor = UIColor.blackColor().CGColor
        myTechTable.layer.cornerRadius = 5
        
        techdespView.layer.borderColor = UIColor.blackColor().CGColor
        techdespView.layer.cornerRadius = 3
        techdespView.layer.borderWidth = 2
        
        getTechnicianTask(techName)
        fetchedResultController2 = getFetchedResultController()
        fetchedResultController2.performFetch(nil)
        
        
        var array : NSArray = NSArray()
        array = fetchedResultController2.fetchedObjects!
        rowCount = array.count        // Do any additional setup after loading the view.
        
        //On Tapping Image
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
    
    override func viewDidAppear(animated: Bool) {
        
          self.navigationItem.setHidesBackButton(true, animated: true)
    }
  
    func getTechnicianTask(techName:NSString)
    {
    
        var appdel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext! = appdel.managedObjectContext
        
        //Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDiscriptors = NSSortDescriptor(key: "status", ascending: false)
        fetchRequest.sortDescriptors = [sortDiscriptors]
        
        //Filtering fetches by technician Name
        let predicate = NSPredicate(format: "techAssigned = '\(techName)'")
        fetchRequest.predicate = predicate
        
        techTasks = context?.executeFetchRequest(fetchRequest, error: nil) as NSArray!
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1;
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return techTasks!.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell?
    {
        var cell1:TechCustomCell = tableView.dequeueReusableCellWithIdentifier("techCell") as TechCustomCell

        let task = techTasks!.objectAtIndex(indexPath.row) as Task
        cell1.techReqId.text = task.reqId
        cell1.techArea.text = task.address.area
        cell1.closeBtn.setTitle("X", forState: UIControlState.Normal)
        
        if(task.status == "Open")
        {
            
            cell1.closeBtn.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside )
            
        }
        else if(task.status == "Closed")
        {
            cell1.closeBtn.enabled = false
            cell1.closeBtn.setTitle("", forState: UIControlState.Normal)
            
        }
        return cell1
        
    }
    
    func buttonAction(sender:AnyObject)
    {
        
        
    //Storing
       var cell1:TechCustomCell = TechCustomCell()
       
        if (currentStatus != nil)
        {

        
            if(currentStatus.status == "Open")
            {
                currentStatus.status = "Closed"
            
                managedObjectContext?.save(nil)
            
                cell1.closeBtn.enabled = false
               
            
                if currentIndexPath != nil
                {
                    myTechTable.reloadRowsAtIndexPaths(NSArray(object: currentIndexPath), withRowAnimation: UITableViewRowAnimation.Left)
                }
                else
                {
                    myTechTable.reloadData()
                }
            }
            
        
        }
            
        else if(currentStatus == nil)
        {
                println("Select the row then Click")
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        var cell1:TechCustomCell = tableView.dequeueReusableCellWithIdentifier("techCell") as TechCustomCell
        
        techdespView.hidden = false
        
        let req = fetchedResultController2.objectAtIndexPath(indexPath) as Task
        
        if(req.status == "Open")
        {
            currentStatus = req
            currentIndexPath = indexPath
            
            
            
            println("Selcted Row\(req.status)")
        }
            
        else
        {
            
            println("Selcted Row\(req.status)")
            
        }
        
        techDesp.text = req.desp
        techCity.text = req.address.city
        techStreet.text = req.address.street
        techPriority.text = req.priority
    
        lat = req.address.latitude
        long = req.address.longitude
       
        
        
        let imageSet: NSSet = req.image
        var imageArr = imageSet.allObjects as NSArray
        var i:Int = Int()
        
        for var i=0; i<3; i++
        {
            if(i==0)
            {
                let imageObj: Image = imageArr.objectAtIndex(i) as Image
                firstImage = UIImage(data: imageObj.image)
            }
            if(i==1)
            {
                
                println("Second loop")
                
                let imageObj: Image = imageArr.objectAtIndex(i) as Image
                secondImage = UIImage(data: imageObj.image)
            }
            if(i==2)
            {
                let imageObj: Image = imageArr.objectAtIndex(i) as Image
                thirdImage = UIImage(data: imageObj.image)
            }
        }
        
        image1.image = firstImage
        image2.image = secondImage
        image3.image = thirdImage
        
        
    
    }
    
    func tappedView(sender:UIGestureRecognizer)
    {
        dispatch_async(dispatch_get_main_queue() ) {
            
            let selectedImageView: UIImageView = sender.view as UIImageView
            
            
            if ( selectedImageView == self.image1 && !(self.image1.image == UIImage(named: "noimage.png")))
                
            {
                var zoomImage:ZoomView = self.storyboard?.instantiateViewControllerWithIdentifier("ZoomView") as ZoomView
                zoomImage.image = self.image1.image!
                self.presentViewController(zoomImage, animated: true, completion: nil)
            }
            
            if( selectedImageView == self.image2 && !(self.image2.image == UIImage(named: "noimage.png")))
            {
                var zoomImage:ZoomView = self.storyboard?.instantiateViewControllerWithIdentifier("ZoomView") as ZoomView
                zoomImage.image = self.image2.image!
                self.presentViewController(zoomImage, animated: true, completion: nil)
                
            }
            if( selectedImageView == self.image3 && !(self.image3.image == UIImage(named: "noimage.png")))
            {
                var zoomImage:ZoomView = self.storyboard?.instantiateViewControllerWithIdentifier("ZoomView") as ZoomView
                zoomImage.image = self.image3.image!
                self.presentViewController(zoomImage, animated: true, completion: nil)
            }
            
        }
        
        
        
    }
    
    //Route Map
    @IBAction func btnRouteMap(sender: AnyObject) {

        var route = self.storyboard?.instantiateViewControllerWithIdentifier("routeMap") as RouteMap
        route.name1 = lat
        route.name2 = long
        self.navigationController?.pushViewController(route, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
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
