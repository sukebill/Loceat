//
//  StartViewController.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 11/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit
import GoogleMaps

class StartViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}

// MARK: Set Up

extension StartViewController {
    private func setUpViews() {
        setUpMap()
    }
    
    private func setUpMap() {
        mapView.camera = .athens
    }
}

// MARK: GMSMapViewDelegate

extension StartViewController: GMSMapViewDelegate {
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        
    }
}
