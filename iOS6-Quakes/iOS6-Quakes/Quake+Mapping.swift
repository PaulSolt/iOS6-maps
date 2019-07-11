//
//  Quake+Mapping.swift
//  iOS6-Quakes
//
//  Created by Paul Solt on 7/11/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import MapKit

extension Quake: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return geometry.location
    }
    
    var title: String? {
        return properties.place
    }
    
    var subtitle: String? {
        return "\(properties.time)"
    }
    
}
