//
//  MapView.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

protocol myLocation
{
    func myLatAndLong(lati : CLLocationDegrees, longi:CLLocationDegrees)
    
}
class MapView: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet var myMapView: MKMapView!
    var manager = CLLocationManager()
    
    var delegate:myLocation? = nil
    
    var lat:CLLocationDegrees = CLLocationDegrees()
    var long:CLLocationDegrees = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        myMapView.showsUserLocation = true
        addLongPressTap()
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
            var latDelta:CLLocationDegrees = 0.01
            var lonDelta:CLLocationDegrees = 0.01
            var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation.coordinate, theSpan)
            myMapView.setRegion(theRegion, animated: true)
            
            
        }
    }
    func addLongPressTap() {
        
        var longPress:UILongPressGestureRecognizer = UILongPressGestureRecognizer()
        
        longPress.addTarget(self, action: "addAnnotation:")
        myMapView.addGestureRecognizer(longPress)
        
    }
    
    func addAnnotation(sender:UIGestureRecognizer)
    {
        
        if  sender.state == UIGestureRecognizerState.Ended {
            
            let point:CGPoint = sender.locationInView(myMapView)
            var coordinates:CLLocationCoordinate2D = myMapView.convertPoint(point, toCoordinateFromView: myMapView)
            println(coordinates.latitude)
            println(coordinates.longitude)
            var annotation1 = MKPointAnnotation()
            annotation1.coordinate = coordinates
            annotation1.title = "New Location"
            annotation1.subtitle = "Google Reverse"
            myMapView.removeAnnotations(myMapView.annotations)
            myMapView.addAnnotation(annotation1)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
