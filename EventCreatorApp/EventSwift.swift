//
//  EventSwift.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import Foundation

import MapKit

class EventSwift: NSObject, MKAnnotation {
    
    let eventTitle: String
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.eventTitle = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var eventsubtitle: String {
        return locationName
    }
}
