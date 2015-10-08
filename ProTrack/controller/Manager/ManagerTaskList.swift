//
//  TaskViewController.swift
//  ProTrack
//
//  Created by Priya Kapoor on 27/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData
protocol didUpdateCount
{
    func changeTheCount(high:Int,medium:Int,low:Int)
}

class ManagerTaskList: BaseViewController,UITableViewDelegate, NSFetchedResultsControllerDelegate, UIPopoverPresentationControllerDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate{
    
    
    var actsh1 = UIActionSheet()
    var actsh = UIActionSheet()
    var flag:Int = Int()
    var high1:Int = Int()
    var medium1:Int = Int()
    var low1:Int = Int()
    var areaName:String = String()
    var techTasks:NSArray!
    var areaDictionary = [String: NSArray]()
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    var selectedRows:NSMutableArray = []
    var areaList = ["Nagwara","BTM","Kormangla","Banerghatta"]
    
    var priorityList = ["High","Medium" , "Low" ];
    var technicianList = ["Ram","Rahul","Rakesh"];
    var takeBtn : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var  TechFetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    var TaskFetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    var rowCount: Int = Int()
    var rowCount1: Int = Int()
    var currentTask: Task!
    var currentIndexPath: NSIndexPath!
    var delegate:didUpdateCount? = nil
    

    
    @IBOutlet weak var MyView: UIView!
    @IBAction func MyPriorityBtn(sender: AnyObject) {
        
    
        
        actsh.tag = 0
        actsh.delegate = self
        actsh.title = "Priority List"
        for var i:Int = 0;i < 3;i++
        {
        actsh.addButtonWithTitle(priorityList[i])

        }
        actsh.addButtonWithTitle("Cancel")
        actsh.cancelButtonIndex = 3
        actsh.showInView(self.view)
     

        
    }
    @IBAction func MyTechnicianBtn(sender: AnyObject) {
        
        
       
        actsh1.tag = 1
        actsh1.delegate = self
        actsh1.title = "Technician List"
        for var i:Int = 0;i < 3;i++
        {
            actsh1.addButtonWithTitle(technicianList[i])
            
        }
        actsh1.addButtonWithTitle("Cancel")
        actsh1.cancelButtonIndex = 3
        actsh1.showInView(self.view)
    

        
    }
    @IBOutlet weak var lblPriority: UILabel!
    
    @IBOutlet weak var lblTechnician: UILabel!
    
    @IBOutlet weak var tableViewPriority: UITableView!
    
    @IBOutlet weak var MyTableView: UITableView!
    
    @IBOutlet weak var MyTechnician: UILabel!
    
    @IBOutlet weak var MyDescription: UILabel!
    
    @IBOutlet weak var MyImages: UILabel!
    
    @IBOutlet weak var tableViewTech: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        flag = 0
        self.MyView.layer.borderColor = UIColor.blackColor().CGColor
        self.MyView.layer.borderWidth = 1
        self.MyView.layer.cornerRadius = 5
        self.MyTableView.layer.borderColor = UIColor.blackColor().CGColor
        self.MyTableView.layer.borderWidth = 1
        self.MyTableView.layer.cornerRadius = 5
        high1 = 0
        medium1 = 0
        low1 = 0
        MyView.becomeFirstResponder()
        
                var techIn:TechnicianData = TechnicianData()
        for var i:Int = 0;i<3;i++
        {
            
            
            if var techObj = techFetchRequest_Name(technicianList[i]) {
                
                println("\(technicianList[i]) already there")
                
            }
            else
            {
                
                var techObj = techIn.createProduct()!
                techObj.name = technicianList[i]
                techIn.insertUser()
            }
            
            
        }
        
        TechFetchedResultController = getFetchedResultController()
        TechFetchedResultController.performFetch(nil)
        
        TaskFetchedResultController = getFetchedResultController1()
        TaskFetchedResultController.performFetch(nil)
        
        
        
        var array : NSArray = NSArray()
        array =  TechFetchedResultController.fetchedObjects! //tech
        rowCount = array.count
        
        
        var array1 : NSArray = NSArray()
        array1 =  TaskFetchedResultController.fetchedObjects! //req
        rowCount1 = array1.count
        
        
        self.view.addSubview(MyTableView)
        self.MyTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        MyTableView.reloadData()
        
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
            
            return 20
    }
        
        
    }
    
    func techFetchRequest()->NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "Technician")
        let sortDescriptor = NSSortDescriptor(key:"name", ascending:false)
        fetchRequest.sortDescriptors=[sortDescriptor]
        return fetchRequest
        
    }
    
    func getFetchedResultController()->NSFetchedResultsController
    {
        TechFetchedResultController = NSFetchedResultsController(fetchRequest: techFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return  TechFetchedResultController
        
    }
    
    func taskFetchRequest()->NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:false)
        let sortDescriptor1 = NSSortDescriptor(key:"time", ascending:false)
        
        let taskPredicate1: NSPredicate = NSPredicate(format: "address.area = %@ AND status= %@",areaName ,"Open")
        fetchRequest.predicate = taskPredicate1
        
        
        fetchRequest.sortDescriptors=[sortDescriptor,sortDescriptor1]
        return fetchRequest
        
    }
    
    func getFetchedResultController1()->NSFetchedResultsController
    {
        TaskFetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        println("Count \(TaskFetchedResultController.fetchedObjects?.count)")
        return TaskFetchedResultController
        
    }
    
    
    
    func touchedSet(sender: UIButton)
    {
        tableViewPriority.hidden = false
        tableViewTech.hidden = false
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
         }
    
    func addCategory() {
        
        var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("NewCategory") as UIViewController
        var nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        var popover = nav.popoverPresentationController as UIPopoverPresentationControllerDelegate
        popoverContent.preferredContentSize = CGSizeMake(500,600)

        self.presentViewController(nav, animated: true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int { println("hello")
        if tableView.tag == 111 {
            return rowCount1
        }
            
        else if tableView.tag == 110 {
            return rowCount
            
        }
            
        else if tableView.tag == 101 {
            return self.priorityList.count;
        }
        return 1
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        println("in the table")
        
        if tableView.tag == 111
        {
            println("Table 111")
            var myCell:ManagerCustomCell = tableView.dequeueReusableCellWithIdentifier("requestCell") as ManagerCustomCell
            let req = TaskFetchedResultController.objectAtIndexPath(indexPath) as Task
            println(req.reqId)
            myCell.reqLabel?.font = UIFont.systemFontOfSize(18.0)
            myCell.dateLabel?.font = UIFont.systemFontOfSize(13.0)
            myCell.timeLabel?.font = UIFont.systemFontOfSize(13.0)
            
            myCell.accessoryType = UITableViewCellAccessoryType.DetailButton
            
            
            if (req.reqId != "")  {
                myCell.reqLabel?.text = req.reqId
                myCell.dateLabel?.text = req.date
                myCell.timeLabel?.text = req.time
            }
            
            println("Req Id is \(req.reqId) \nPriority is \(req.priority)")
            if !(req.priority != nil)  {
                
                if req.priority == "" || req.priority == nil
                {
                    println("Empty")
                    myCell.priorityImageView?.backgroundColor = UIColor.clearColor()
                    myCell.priorityImageView?.image = UIImage(named: "icon_empty_checkbox.png")
                    
                }
                
            }
            else {
                if(flag == 0)
                {
                
                if req.priority == "High"{
                    println("high")
                    myCell.priorityImageView?.image = nil
                    myCell.priorityImageView?.backgroundColor = UIColor.redColor()
                    high1 = high1 + 1
                    println("Current High Value is \(high1)")
                    flag = 1
                }
                    
                    
                else if req.priority == "Medium"{
                    println("Medium")
                    myCell.priorityImageView.image = nil
                    myCell.priorityImageView.backgroundColor = UIColor.yellowColor()
                    medium1 = medium1 + 1
                    flag = 1
                    
                }
                else if req.priority == "Low"{
                    println("Low")
                    myCell.priorityImageView.image = nil
                    myCell.priorityImageView.backgroundColor = UIColor.greenColor()
                    low1 = low1 + 1
                    flag = 1
                }
                }
                else if(flag == 1)
                {
                    if req.priority == "High"{
                        println("high")
                        myCell.priorityImageView?.image = nil
                        myCell.priorityImageView?.backgroundColor = UIColor.redColor()
                        println("Current High Value is \(high1)")
                        flag = 0
                    }
                        
                        
                    else if req.priority == "Medium"{
                        println("Medium")
                        myCell.priorityImageView.image = nil
                        myCell.priorityImageView.backgroundColor = UIColor.yellowColor()
                        flag = 0
                        
                    }
                    else if req.priority == "Low"{
                        println("Low")
                        myCell.priorityImageView.image = nil
                        myCell.priorityImageView.backgroundColor = UIColor.greenColor()
                        flag = 0
                    }
                }
                
            }
            
            
            
            if !(req.techAssigned != nil)  {
                
                if req.techAssigned == "" || req.techAssigned == nil
                {
                    println("Empty")
                    
                    myCell.tLabel.hidden = true
                }
                
            }
                
            else{
                myCell.tLabel.hidden = false
            }
            
            
            
            println("Row \(indexPath.row)")
            
            println("tableview")
            return myCell
            
        }

            
        else if tableView.tag == 110{
                        
            let tech =  TechFetchedResultController.objectAtIndexPath(indexPath) as Technician
            var myTechCell = tableView.dequeueReusableCellWithIdentifier("celll") as UITableViewCell!
            //
            if !(myTechCell != nil)
            {
                
                myTechCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celll")
            }
            
            myTechCell.textLabel?.font = UIFont.systemFontOfSize(15.0)
            myTechCell.backgroundColor = UIColor.lightGrayColor()
            myTechCell.textLabel?.alignmentRectInsets()
            
            myTechCell.textLabel?.text = tech.name
            return myTechCell
        }
            
            
        else if tableView.tag == 101{
            var myPriorityCell = tableView.dequeueReusableCellWithIdentifier("celll") as UITableViewCell!
            
            if !(myPriorityCell != nil)
            {
                
                myPriorityCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celll")
            }
            myPriorityCell.textLabel?.font = UIFont.systemFontOfSize(15.0)
            
            
            myPriorityCell.textLabel?.text = self.priorityList[indexPath.row]
            myPriorityCell.backgroundColor = UIColor.lightGrayColor()
            return myPriorityCell
            
            
        }
        
        
        return nil
        
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if tableView.tag == 111{
            
            
            let task = TaskFetchedResultController.objectAtIndexPath(indexPath) as Task
            
            var reqselectedCell:ManagerCustomCell = tableView.cellForRowAtIndexPath(indexPath)! as ManagerCustomCell
            
            
            if !(task.priority != nil) {
                
                if ( reqselectedCell.accessoryType == UITableViewCellAccessoryType.DetailButton) {
                    currentTask = task
                    currentIndexPath = indexPath
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else if(reqselectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark)
                {
                    reqselectedCell.priorityImageView.image = UIImage(named: "icon_empty_checkbox.png")
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.DetailButton
                    currentTask = nil
                    currentIndexPath = nil
                }
                
                
            }
                
            else {
                if(reqselectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark)
                {
                    
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.DetailButton
                    currentTask = nil
                    currentIndexPath = nil
                }
            }
            if !(task.techAssigned != nil) {
                if ( reqselectedCell.accessoryType == UITableViewCellAccessoryType.DetailButton) {
                    currentTask = task
                    currentIndexPath = indexPath
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                

                
            }
            
            
        }
        
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 111{
            return 50.0
        }
        
        if tableView.tag == 110{
            return 30.0
        }
        if tableView.tag == 101{
            return 30.0
            
        }
        return 44.0
        
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        lblTechnician.text = ""
        lblPriority.text = ""
        MyDescription.text = ""
        
        let task = TaskFetchedResultController.objectAtIndexPath(indexPath) as Task
        
        MyView.hidden = false
        
        currentTask = task
        
        if currentTask.priority != nil
        {
            lblPriority.text = currentTask.priority
        }
        
        if currentTask.techAssigned != nil
        {
            lblTechnician.text = currentTask.techAssigned
            
        }
        if currentTask.description != nil
        {
            MyDescription.text = currentTask.desp
            MyDescription.numberOfLines = 0
            MyDescription.preferredMaxLayoutWidth = 70
            MyDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
            MyDescription.sizeToFit()
        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data Adapter
    func techFetchRequest_Name(techName: NSString)-> Technician!
    {
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Technician")
        
        let techPredicate: NSPredicate = NSPredicate(format: "name = %@", techName)
        fetchRequest.predicate = techPredicate
        
        var techies: NSArray! = context.executeFetchRequest(fetchRequest, error: nil)
        
        
        if (techies == nil || techies.count == 0) {
            
            return nil
        }
        return techies.firstObject as Technician
        
    }
    
    
    //MARK:
    override func viewDidDisappear(animated: Bool) {
        currentTask = nil
        currentIndexPath = nil
        println("Disappear")
        
  }
    
    
    @IBAction func reloadBtn(sender: AnyObject) {
        println("Performing")
        var managerHome = self.storyboard?.instantiateViewControllerWithIdentifier("Manager") as ManagerHome
        managerHome.high = high1
        managerHome.low = low1
        managerHome.medium = medium1
       
       self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        println("Hi")
        
        println("Selected action is \(actionSheet.tag)")
        
        if(actionSheet.tag==0)
            
        {
            if currentTask != nil
            {
                if !(currentTask.priority != nil)
                {
            if(buttonIndex==0)
            {
                currentTask.priority = priorityList[0]
                 println("You have assigned \(currentTask.priority)")
                actionSheet.dismissWithClickedButtonIndex(1, animated: true )

            }
                
         if(buttonIndex==1)
            {
                currentTask.priority = priorityList[1]
                }
          if(buttonIndex==2)
                {
                    currentTask.priority = priorityList[2]
                }
                    managedObjectContext.save(nil)
                    
                    if currentIndexPath != nil {
                        MyTableView.reloadRowsAtIndexPaths(NSArray(object: currentIndexPath), withRowAnimation: UITableViewRowAnimation.Left)
                    }
                    else {
                        
                        //This should not be executed, If executing then code problem
                        MyTableView.reloadData()
                    }
                    
                    currentTask = nil
                    currentIndexPath = nil
                }
            }
        }
            
            
        else if(actionSheet.tag==1)
        {
            if currentTask != nil
            {
                if !(currentTask.techAssigned != nil)
            {
            
            if(buttonIndex==0)
            {
                currentTask.techAssigned = technicianList[0]
                actionSheet.dismissWithClickedButtonIndex(1, animated: true )
            }
            
                if(buttonIndex==1)
                {
                    currentTask.techAssigned = technicianList[1]
                }
                if(buttonIndex==2)
                {
                    currentTask.techAssigned = technicianList[2]
                }
                managedObjectContext.save(nil)
                
                if currentIndexPath != nil {
                    MyTableView.reloadRowsAtIndexPaths(NSArray(object: currentIndexPath), withRowAnimation: UITableViewRowAnimation.Left)
                }
                else {
                    
                    //This should not be executed, If executing then code problem
                    MyTableView.reloadData()
                }
                
                currentTask = nil
                currentIndexPath = nil
            }
        }
        }
}
    
}


