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

    override func viewDidLoad() {
        super.viewDidLoad()

        requestLocationPermission()
        addAnnotations()
    }

    func requestLocationPermission() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func addAnnotations() {
        mapView.addAnnotations(AnnotationResource.annotations)
    }

    func viewControllerForAnnotation(annotation: Annotation) -> UIViewController? {
        guard let viewController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController else {
            return nil
        }

        viewController.annotation = annotation
        return viewController
    }

    func rectForAnnotationViewWithPopover(view: MKAnnotationView) -> CGRect? {

        // Look for a popover, and include it in the rect if it exists
        var popover: UIView?

        for view in view.subviews {
            for view in view.subviews {
                for view in view.subviews {
                    popover = view
                }
            }
        }

        // Add the popover to the 3D Touch rect
        if let popover = popover, frame = popover.superview?.convertRect(popover.frame, toView: view) {
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

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? Annotation else {
            return nil
        }

        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationViewID) {
            annotationView.annotation = annotation
            return annotationView
        }
        else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            annotationView.canShowCallout = true
            registerForPreviewingWithDelegate(self, sourceView: annotationView)
            return annotationView
        }
    }

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {

        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)

        mapView.setRegion(region, animated: true)
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? Annotation, viewController = viewControllerForAnnotation(annotation) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension MapViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        guard let annotationView = previewingContext.sourceView as? MKPinAnnotationView else {
            return nil
        }
        guard let annotation = annotationView.annotation as? Annotation else {
            return nil
        }

        if let popoverFrame = rectForAnnotationViewWithPopover(annotationView) {
            previewingContext.sourceRect = popoverFrame
        }

        return viewControllerForAnnotation(annotation)
    }

    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
