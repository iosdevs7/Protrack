//
//  TechCustomCell.swift
//  ProTrack
//
//  Created by Sunny on 29/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class TechCustomCell: UITableViewCell {

    @IBOutlet var techArea: UILabel!
   
    @IBOutlet var techReqId: UILabel!
    

    @IBOutlet var techStatus1: UISwitch!
    var closeBtn : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        closeBtn.frame = CGRectMake(228, 15, 20, 20)
        closeBtn.backgroundColor = UIColor.whiteColor()
        self.addSubview(closeBtn)    }


    @IBAction func techStatus(sender: AnyObject) {
   
        if techStatus1.on
            
        {
            println("It is on")
        }
        else
        {
            var appdel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context:NSManagedObjectContext! = appdel.managedObjectContext
            var request = NSFetchRequest(entityName:"Task")
            var result:NSArray! = context.executeFetchRequest(request,error: nil)
            if(result.count > 0)
            {
                var res = result[0] as NSManagedObject

                var res1 = res.valueForKey("status") as String
                res1 = "Closed"
                println(res1)
}
}
}
}
