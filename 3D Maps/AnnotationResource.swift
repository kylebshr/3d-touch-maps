//
//  AnnotationResource.swift
//  3D Maps
//
//  Created by Kyle Bashour on 5/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import CoreLocation

struct AnnotationResource {

    static var annotations: [Annotation] {

        let red = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.18139, longitude: -122.45232),
            title: "Red Place",
            color: .redColor()
        )
        let blue = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.68139, longitude: -122.05232),
            title: "Blue Place",
            color: .blueColor()
        )
        let green = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 36.98139, longitude: -122.15232),
            title: "Green Place",
            color: .greenColor()
        )
        let purple = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.28139, longitude: -121.65232),
            title: "Purple Place",
            color: .purpleColor()
        )
        let orange = Annotation(
            coordinate: CLLocationCoordinate2D(latitude: 37.78139, longitude: -122.35232),
            title: "Orange Place",
            color: .orangeColor()
        )

        return [red, blue, green, purple, orange]
    }
}
