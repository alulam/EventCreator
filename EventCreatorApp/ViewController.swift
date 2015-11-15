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
  
        
//        let event = MKPointAnnotation()
//        
//        
//        event.coordinate.latitude = 40.001952
//        event.coordinate.longitude = -83.016112
//        
//        event.title = "Dreese"
//        event.subtitle = "Cool Event Happening Here, what if I make this super long?"
//        
//        
//        
//        
//        mapView.addAnnotation(event)
        
        //8888888
        let location = "2015 Neil Ave, Columbus, OH 43210"
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
            
            if((error) != nil){
                
                print("Error", error)
            }else{
                
                let placemark:CLPlacemark = placemarks![0] as! CLPlacemark
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinates
                pointAnnotation.title = "Ohio Union"
                
                
                self.mapView?.addAnnotation(pointAnnotation)
                //self.mapView?.centerCoordinate = coordinates
                self.mapView?.selectAnnotation(pointAnnotation, animated: true)
                
                print("Added annotation to map view")
            }
            
        })
        let washington = Occur(title: "Dreese", coordinate: CLLocationCoordinate2D(latitude: 40.001952, longitude: -83.016112), info: "Named after George himself.")
        
        mapView.addAnnotation(washington)

        
        //8888888
        
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
////        if !(annotation is MKPointAnnotation) {
////            return nil
////        }
//        
//        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
//        if view == nil {
//            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//            view!.canShowCallout = true
//            view!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
//        }
//        return view
//    }
    
//    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//       print("Pressed")
//    }

    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView {
        let identifier = "Occur"
        
        // 2
        if annotation.isKindOfClass(Occur.self) {
            // 3
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                //4
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                // 5
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                // 6
                annotationView!.annotation = annotation
            }
            
            return annotationView!
        }
    
        
        // 7
        return MKAnnotationView()
        
//        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
//        var rightCalloutAccessoryView: UIView!
//        
//        if pinView == nil{
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            pinView?.canShowCallout = true
//            pinView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//        }else{
//            pinView?.annotation = annotation
//        }
//        
//        return pinView
        
        
//        if annotation.isKindOfClass(ViewController.self) {
//            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
//                annotationView.annotation = annotation
//                return annotationView
//            } else {
//                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
//                annotationView.enabled = true
//                annotationView.canShowCallout = true
//                
//                let btn = UIButton(type: .DetailDisclosure)
//                annotationView.rightCalloutAccessoryView = btn
//                return annotationView
//            }
//        }
//        
//        return nil
    }
    

    
    
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
         print("Pin pressed")
    
        
        let event = view.annotation as! Occur
        let placeName = event.title
        let placeInfo = event.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    
   
//    func mapView (mapView: MKMapView,
//        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//            
//        
//            let pinView:MKPinAnnotationView = MKPinAnnotationView()
//            pinView.annotation = annotation
//            //pinView.pinColor = MKPinAnnotationColor.Red
//            pinView.animatesDrop = true
//            pinView.canShowCallout = true
//            
//            return pinView
//            
//               }
//    
//    
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
//        calloutAccessoryControlTapped control: UIControl) {
//            print("Disclosure Pressed! \(view.annotation!.subtitle)")
//            if control == view.rightCalloutAccessoryView {
//                
//                
//                
//            }
//            
//    }
    
    
 


}

