//
//  ManagerHome.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ManagerHome: BaseViewController, MKMapViewDelegate
{
    var highCount:Int = Int()
    var mediumCount:Int = Int()
    var lowCount:Int = Int()
    var taskUnAssigned:Int = Int()
    var arrayArea = []
    var high:Int = 0
    var medium:Int = 0
    var low :Int = 0
    @IBOutlet var MyMapView: MKMapView!
    @IBOutlet var MapLabel: UILabel!
    
    var cust:CustomCircle = CustomCircle()
    
    var areaList = ["Nagwara","BTM","Kormangla","Banerghatta"]
    
    
    
    var  annotation = CustomAnnotation()
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    func taskFetchRequest()->NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:false)
        fetchRequest.sortDescriptors=[sortDescriptor]
        return fetchRequest
        
    }
    
    func getFetchedResultController()->NSFetchedResultsController
    {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
  override func viewWillAppear(animated: Bool) {
    
        
    
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        MyMapView.delegate = self;
        
        
        //MAP VIEW
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        
        for var i:Int = 0;i<4;i++
        {
            
            let fetchRequest1 = NSFetchRequest(entityName: "Task")
            
            let taskPredicate1: NSPredicate = NSPredicate(format: "address.area = %@",areaList[i] )
            fetchRequest1.predicate = taskPredicate1
            
            var task1:NSArray = context.executeFetchRequest(fetchRequest1, error: nil)! as NSArray
            
            
            
            if (task1 == "" )
            {
                
                println("no address")
            }
                
            else
            {
                for i in task1
                {
                    let currentTask: Task = i as Task
                    
                    if currentTask.priority == "High"
                    {
                        println("Task Requests are \(currentTask.reqId) and \(currentTask.priority) ")
                        highCount++
                    }
                    
                    if currentTask.priority == "Medium"
                    {
                        println("Task Requests are \(currentTask.reqId) and \(currentTask.priority) ")
                        mediumCount++
                    }
                    
                    
                    if currentTask.priority == "Low"
                    {
                        println("Task Requests are \(currentTask.reqId) and \(currentTask.priority) ")
                        lowCount++
                    }

                    
                }
                
                
            }
            
            taskUnAssigned = task1.count - (highCount + mediumCount + lowCount)
            
            if(task1.count>0)
            {
                
                for t in task1
                {
                    
                    var res:Task = t as Task
                    var lati:CLLocationDegrees = res.address.latitude as CLLocationDegrees
                    var longi:CLLocationDegrees = res.address.longitude as CLLocationDegrees
                    var location = CLLocationCoordinate2DMake(lati, longi)
                    
                    let span = MKCoordinateSpanMake(0.15, 0.15)
                    var region = MKCoordinateRegion(center: location, span: span)
                    
                    MyMapView.setRegion(region, animated: true)
                    
                    
                    annotation.setCoordinate(location)
                    annotation.title = areaList[i]
                    
                    annotation.subtitle = "India"
                    
                    highCount = highCount + high
                    mediumCount = mediumCount + medium
                    lowCount = lowCount + low
                    
                    annotation.title1 = [String(highCount),String(lowCount),String(mediumCount),String(taskUnAssigned)]
                    
                    
                    MyMapView.addAnnotation(annotation)
                    
                    highCount = 0
                    
                    mediumCount = 0
                    
                    lowCount = 0
                    
                    annotation = CustomAnnotation()
                }
                
                
                
                
                
            }
        }
    }
    // ANNOTATION VIEW
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let reuseId = "test"
        
        if !(annotation is CustomAnnotation)
        {
            return nil
        }
        
        
        var tempAnn=annotation as CustomAnnotation
        
        var anView = MyMapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        tempAnn.custView1 = CustomCircle(x: -30 , y: -10, width: 200, height: 200, title:tempAnn.title1)
        
        
        
        if anView == nil
        {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            var button = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
            
            for var i:Int = 0;i < areaList.count; i++ {
            
                if areaList[i] == annotation.title {
                
                    button.tag = i
                    break;
                }
            }
            
       
            
            button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            anView.rightCalloutAccessoryView = button
            anView.bringSubviewToFront(button)
            
            anView.canShowCallout = true
            
            
            tempAnn.custView1.userInteractionEnabled = true
            
            
            anView.addSubview(tempAnn.custView1)
            
        }
            
        else
        {
//            for subView in anView.subviews {
//                subView.removeFromSuperview()
//            }
//   
//            anView.addSubview(tempAnn.custView1)
            anView.annotation = annotation
        }
        
        return anView
        
        
    }
    
    
    
    
    
    
    
    func buttonPressed(sender:UIButton)
    {
         var viewControllerObject:ManagerTaskList = self.storyboard?.instantiateViewControllerWithIdentifier("TVC") as ManagerTaskList
        if (sender.tag == 0)
        {
       
        viewControllerObject.areaName = areaList[0]

        }
        else if (sender.tag == 1)
      
        {
            viewControllerObject.areaName = areaList[1]
     
        }
        else if (sender.tag == 2)
        {
        
            viewControllerObject.areaName = areaList[2]
           
        }
        else if (sender.tag == 3)
        {
           
            viewControllerObject.areaName = areaList[3]
           
        }
         self.navigationController?.pushViewController(viewControllerObject, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

