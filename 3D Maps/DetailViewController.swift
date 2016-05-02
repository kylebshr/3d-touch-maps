//
//  DetailViewController.swift
//  3D Maps
//
//  Created by Kyle Bashour on 5/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet private var locationLabel: UILabel!

    var annotation: Annotation!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureForAnnotation()
    }

    func configureForAnnotation() {
        locationLabel.text = annotation.title
        view.backgroundColor = annotation.color
    }
}
