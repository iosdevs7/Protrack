//
//  RequestLog.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class RequestLog: BaseViewController
{
    
    @IBAction func btnLogout(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var myTableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    var rowCount: Int = Int()
    
    func taskFetchRequest()->NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:false)
        let st = NSSortDescriptor(key:"time", ascending:false)
        fetchRequest.sortDescriptors=[sortDescriptor,st]
        return fetchRequest
        
    }
    
    func getFetchedResultController()->NSFetchedResultsController
    {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.myTableView.layer.borderColor = UIColor.blackColor().CGColor
        self.myTableView.layer.borderWidth = 2
        self.myTableView.layer.cornerRadius = 5
        fetchedResultController = getFetchedResultController()
        //fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
        var array : NSArray = NSArray()
        array = fetchedResultController.fetchedObjects!
        rowCount = array.count
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Request Log"
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = "Back"
        
    }
    
    //MARK: UITableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return rowCount
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell?
    {
        
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        let task = fetchedResultController.objectAtIndexPath(indexPath) as Task
        cell.reqId.text = task.reqId
        cell.status.text = task.status
        cell.lblDate.text = task.date
        cell.lblTime.text = task.time
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier=="segue"
        {
            let cell = sender as UITableViewCell
            let indexPath = myTableView.indexPathForCell(cell)
            let despCtrl:RequestDescription = segue.destinationViewController as RequestDescription
            let task:Task = fetchedResultController.objectAtIndexPath(indexPath!) as Task
            
            despCtrl.str = task.reqId
            var imageArr = task.image.allObjects as NSArray
            var i:Int = Int()
            
            for var i=0; i<3; i++
            {
                if(i==0)
                {
                    let imageObj: Image = imageArr.objectAtIndex(i) as Image
                    despCtrl.firstImage = UIImage(data: imageObj.image)
                }
                if(i==1)
                {
                    let imageObj1: Image = imageArr.objectAtIndex(i) as Image
                    despCtrl.secondImage = UIImage(data: imageObj1.image)
                }
                if(i==2)
                {
                    let imageObj2: Image = imageArr.objectAtIndex(i) as Image
                    despCtrl.thirdImage = UIImage(data: imageObj2.image)
                }
            }
            
            
        }
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
}
