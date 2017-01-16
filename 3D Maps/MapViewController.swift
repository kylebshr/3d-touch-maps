//
//  ViewController.swift
//  3D Maps
//
//  Created by Kyle Bashour on 5/2/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let annotationViewID = "annotation_view"
    lazy var locationManager = CLLocationManager()
    var didUpdateRegion = false

    override func viewDidLoad() {
        super.viewDidLoad()

        requestLocationPermission()
        addAnnotations()
    }

    func requestLocationPermission() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func addAnnotations() {
        mapView.addAnnotations(AnnotationResource.annotations)
    }

    func viewController(for annotation: Annotation) -> UIViewController? {

        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return nil
        }

        viewController.annotation = annotation
        return viewController
    }

    /*
     If the annotation view has a popover, we need to get the rect
     of the popover *and* the annotation view for the sourceRect.
     You could also not add the annotation view height, if you
     would just like the popover to not blur.
    */
    func rectForAnnotationViewWithPopover(_ view: MKAnnotationView) -> CGRect? {

        var popover: UIView?

        for view in view.subviews {
            for view in view.subviews {
                for view in view.subviews {
                    popover = view
                }
            }
        }

        if let popover = popover, let frame = popover.superview?.convert(popover.frame, to: view) {
            return CGRect(
                x: frame.origin.x,
                y: frame.origin.y,
                width: frame.width,
                height: frame.height + view.frame.height
            )
        }

        return nil
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? Annotation else {
            return nil
        }

        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewID) {
            annotationView.annotation = annotation
            return annotationView
        }
        else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView.canShowCallout = true
            registerForPreviewing(with: self, sourceView: annotationView)
            return annotationView
        }
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

        guard !didUpdateRegion else { return }

        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)

        mapView.setRegion(region, animated: true)

        didUpdateRegion = true
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? Annotation, let viewController = viewController(for: annotation) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension MapViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        guard let annotationView = previewingContext.sourceView as? MKPinAnnotationView else {
            return nil
        }
        guard let annotation = annotationView.annotation as? Annotation else {
            return nil
        }

        if let popoverFrame = rectForAnnotationViewWithPopover(annotationView) {
            previewingContext.sourceRect = popoverFrame
        }

        return viewController(for: annotation)
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
