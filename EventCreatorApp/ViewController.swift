//
//  ViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse
import MapKit
import UIKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    
    var eventsArray:NSMutableArray = NSMutableArray()

    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadMap(){
        
        let initialLocation = CLLocation(latitude: 39.999665, longitude: -83.013100)
        
        centerMapOnLocation(initialLocation)
        
        
        
        
        
        
        self.eventsArray.removeAllObjects()
        
        let query = PFQuery(className: "Event")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, myerror: NSError?) -> Void in
            
            if(myerror == nil){
                print("found \(objects!.count) events")
                
                
                
                for event in objects! {
                    
                    //**********
                    
                    let location = event.objectForKey("eventAddress") as! String
                    let geocoder:CLGeocoder = CLGeocoder()
                    geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
                        
                        if((error) != nil){
                            
                            print("Error", error)
                        }else{
                            
                            let placemark:CLPlacemark = placemarks![0]
                            let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                            
                            let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                            pointAnnotation.coordinate = coordinates
                            pointAnnotation.title = event.objectForKey("eventTitle") as? String
                            pointAnnotation.subtitle = event.objectForKey("eventDescription") as? String
                            
                            
                            self.mapView?.addAnnotation(pointAnnotation)
                            //self.mapView?.centerCoordinate = coordinates
                            self.mapView?.selectAnnotation(pointAnnotation, animated: true)
                            
                            print("Added annotation to map view")
                        }
                        
                    })
                    
                    //**********
                    
                }
                
            }
            
        }

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.loadMap()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
    }

}

