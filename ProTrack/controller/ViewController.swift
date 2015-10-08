//
//  ViewController.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet var txtMobileNo: UITextField!
    @IBOutlet var txtPasswrd: UITextField!
    @IBOutlet var mobView: UIView!
    @IBOutlet var passView: UIView!
   
    @IBAction func txtMobile(sender: AnyObject)
    {
        if(countElements(txtMobileNo.text)  >= 10)
        {
              txtMobileNo.endEditing(true)
        }

    }
    
    @IBAction func btnLogin()
    {
        if(countElements(txtMobileNo.text) != 10)
        {
            let alert = UIAlertView(title: "WARNING", message: "ENTER 10 DIGIT MOBILE NUMBER", delegate: nil, cancelButtonTitle: "OK!")
            alert.show()
        }
        
        else
            
        {
            
            //Post Method
            
            var url:NSURL = NSURL(string: "https://TelcoSample.mybluemix.net/login")
            var request:NSMutableURLRequest=NSMutableURLRequest(URL: url)
            
            var keys:NSArray=NSArray(objects: "_id","password","role")
            var objects:NSArray=NSArray(objects: txtMobileNo.text,txtPasswrd.text,"Customer")
            
            var object:NSDictionary=NSDictionary(objects: objects, forKeys: keys)
            
            
            var jsonObject=NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.allZeros, error: nil)
            var response: NSURLResponse?
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPMethod="POST"
            request.HTTPBody = jsonObject

            var responseData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
            
            
            //Get Method
            var url1:NSURL = NSURL(string: "https://TelcoSample.mybluemix.net/login1/")
            var request1:NSMutableURLRequest=NSMutableURLRequest(URL: url1)
            
            
            request1.HTTPMethod="GET"
            request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request1.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var responseData1 = NSURLConnection.sendSynchronousRequest(request1, returningResponse: nil, error: nil) as NSData?
            
            var error :NSError?
            
            let res = response as NSHTTPURLResponse
            
            
            println("Response code: \(res.statusCode)")
            
            //If failure
            if (res.statusCode >= 400 && res.statusCode < 500)
            {
                
                var err :NSError?
                
                var responseArray = NSJSONSerialization.JSONObjectWithData(responseData!, options:NSJSONReadingOptions.MutableLeaves, error: &err) as? NSArray
                
                
                if(responseArray?.count == nil)
                {
                    println("wrong password")
                    let alert = UIAlertView(title: "WARNING", message: "INVALID MOBILE NUMBER OR PASSWORD", delegate: nil, cancelButtonTitle: "OK!")
                    alert.show()
                }
                
                
                
            }
            
            //If success
            if (res.statusCode<400)
            {
                var err :NSError?
                let responseArray1 = NSJSONSerialization.JSONObjectWithData(responseData1!, options:NSJSONReadingOptions.MutableLeaves, error: &err) as? NSArray
                
             for res in responseArray1!
             {
               
                var mobileno = res["_id"] as NSString
                var role = res["role"] as NSString
                var name = res["userName"] as NSString
                
                
                if( txtMobileNo.text == mobileno  && role == "Manager" )
                {
                    //go to manager page
                    var manager:ManagerHome = self.storyboard?.instantiateViewControllerWithIdentifier("Manager") as ManagerHome
                    
                    self.navigationController?.pushViewController(manager, animated: true)
              
                    
                }
                else if(txtMobileNo.text == mobileno  && role == "Customer")
                {
                    
                    //Go to Customer Page
                    
                    var customer = self.storyboard?.instantiateViewControllerWithIdentifier("Customer") as CustomerHome
                    customer.name1 = name
                    self.navigationController?.pushViewController(customer, animated: true)
                 
                    
                }
                    
                else if(txtMobileNo.text == mobileno  && role == "Technician")
                {
                    //Go to Technician Page
                    
                    var technician = self.storyboard?.instantiateViewControllerWithIdentifier("Technician") as TechnicianHome
                    technician.techName = name
                    println( technician.techName)
                    
                    self.navigationController?.pushViewController(technician, animated: true)
                    
                   
                    
                    
                }
            }
                
            txtMobileNo.text = ""
            txtPasswrd.text = ""
        
            }
        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        txtMobileNo.resignFirstResponder()
        
        txtPasswrd.resignFirstResponder()
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
      textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        txtMobileNo.becomeFirstResponder()
        
        self.passView.layer.cornerRadius = 1.0;
        self.passView.layer.borderWidth = 0.0;
        self.mobView.layer.cornerRadius = 1.0
        self.mobView.layer.borderWidth = 0.0
        
        txtMobileNo.delegate = self
        txtPasswrd.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

