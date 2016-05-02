//
//  Annotation.swift
//  3D Maps
//
//  Created by Kyle Bashour on 5/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {

    @objc var coordinate: CLLocationCoordinate2D
    @objc var title: String?

    let color: UIColor

    init(coordinate: CLLocationCoordinate2D, title: String, color: UIColor) {
        self.coordinate = coordinate
        self.title = title
        self.color = color
    }
}
