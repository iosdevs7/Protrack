//
//  RouteMap.swift
//  ProTrack
//
//  Created by Sunny on 07/10/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import MapKit
class RouteMap: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet var myMapView: MKMapView!

    var location = CLLocation()
    var manager = CLLocationManager()
    var name1:CLLocationDegrees = CLLocationDegrees()
    var name2:CLLocationDegrees = CLLocationDegrees()
    var lat:CLLocationDegrees = 40.707184
    var long:CLLocationDegrees = -73.998392
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        myMapView.delegate = self
        myMapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: \(error.localizedDescription)")
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        println("new Location: \(newLocation)")
        let currentLocation = newLocation
       
        if currentLocation != nil
        {
            println(currentLocation.coordinate.latitude)
            println(currentLocation.coordinate.longitude)
            var latDelta:CLLocationDegrees = 0.005
            var lonDelta:CLLocationDegrees = 0.005
            var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            var theRegion:MKCoordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, span: theSpan)
            myMapView.setRegion(theRegion, animated: true)
            let c1 = currentLocation.coordinate
        }
    }
    
    @IBAction func txtRoute(sender: AnyObject)
    {
        var urlString:NSString = "http://maps.apple.com/maps?daddr=\(lat),\(long)" as NSString

        UIApplication.sharedApplication().openURL(NSURL.URLWithString(urlString))
    }
    override func viewDidDisappear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
