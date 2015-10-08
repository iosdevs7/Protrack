//
//  CustomerHome.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class CustomerHome: BaseViewController,datatransferedDelegate {
    var name1 : String = String()
    @IBOutlet var txtLabel: UILabel!
    
    @IBOutlet var myNavi: UINavigationBar!
    
    
    @IBAction func btnRequestLog(sender: AnyObject)
    {
        
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        txtReqId.text = ""
        txtDate.text = ""
    }
    @IBAction func btnNewRequest(sender: AnyObject)
    {
        
    }
    @IBOutlet var txtReqId: UILabel!
    
    @IBOutlet var txtDate: UILabel!
    
    //ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        txtLabel.text = name1
        self.navigationItem.setHidesBackButton(true , animated: true)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="mysegue"
        {
            let newReq:NewRequest = segue.destinationViewController as NewRequest
            newReq.delegate = self
        }
        else if segue.identifier == "reqLog"
        {
            let reqLog:RequestLog = segue.destinationViewController as RequestLog
            
        }
        
    }
    
    //Toast
    func didUserInformation(info: NSString, date :NSString , time :NSString) {
        txtReqId.text = "Your Request ID is : " + info
        txtDate.text = "Date:" + date + " Time:" + time
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        txtReqId.text = ""
        txtDate.text = ""
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
