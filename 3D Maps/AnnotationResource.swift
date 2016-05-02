//
//  AnnotationResource.swift
//  3D Maps
//
//  Created by Kyle Bashour on 5/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct AnnotationResource {

    static var annotations: [Annotation] {

        let red = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.18139, longitude: -122.45232),
            title: "Red Place",
            color: UIColor(red:0.75, green:0.23, blue:0.19, alpha:1.00)
        )
        let blue = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.68139, longitude: -122.05232),
            title: "Blue Place",
            color: UIColor(red:0.02, green:0.24, blue:0.50, alpha:1.00)
        )
        let green = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 36.98139, longitude: -122.15232),
            title: "Green Place",
            color: UIColor(red:0.28, green:0.54, blue:0.09, alpha:1.00)
        )
        let purple = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.28139, longitude: -121.65232),
            title: "Purple Place",
            color: UIColor(red:0.38, green:0.27, blue:0.58, alpha:1.00)
        )
        let orange = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.78139, longitude: -122.35232),
            title: "Orange Place",
            color: UIColor(red:0.79, green:0.22, blue:0.09, alpha:1.00)
        )

        return [red, blue, green, purple, orange]
    }
}
