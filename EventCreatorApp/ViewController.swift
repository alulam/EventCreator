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

class ViewController: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 39.999665, longitude: -83.013100)
        
        centerMapOnLocation(initialLocation)
        
        let event = EventSwift(title: "Dreese",
            locationName: "dreese labs",
            discipline: "cse",
            coordinate: CLLocationCoordinate2D(latitude: 40.001952, longitude: -83.016112))
        
        mapView.addAnnotation(event)
        
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    
 


}

