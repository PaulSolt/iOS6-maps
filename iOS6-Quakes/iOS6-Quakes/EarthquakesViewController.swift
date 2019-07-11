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

        quakeFetcher.fetchQuakes { (quakes, error) in
            if let quakes = quakes {
                print("It's alive! \(quakes.count)")
            }
        }
        
        
    }


}

