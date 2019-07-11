//
//  EarthquakesViewController.swift
//  iOS6-Quakes
//
//  Created by Paul Solt on 7/11/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import MapKit

class EarthquakesViewController: UIViewController {
    private lazy var quakeFetcher = QuakeFetcher()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "QuakeAnnotationView")
        
        fetchQuakes()
    }

    private func fetchQuakes() {
        quakeFetcher.fetchQuakes { (quakes, error) in
            
            if let error = error {
                print("Error fetching quakes: \(error)")
                return
            }
            
            guard let quakes = quakes else { return }
            
            print("It's alive! \(quakes.count)")
            
            DispatchQueue.main.async {
                self.mapView.addAnnotations(quakes)
            }
        }
    }

}

extension EarthquakesViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Create an annotation view
        
        guard let quake = annotation as? Quake else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "QuakeAnnotationView",
                                                                   for: annotation) as! MKMarkerAnnotationView
        
        annotationView.glyphImage = UIImage(named: "QuakeIcon")
        annotationView.glyphTintColor = .white
        annotationView.markerTintColor = .blue
        
        annotationView.canShowCallout = true
        let detailView = QuakeDetailView(frame: .zero)
        detailView.quake = quake
        annotationView.detailCalloutAccessoryView = detailView
        
        return annotationView
    }
    
}
