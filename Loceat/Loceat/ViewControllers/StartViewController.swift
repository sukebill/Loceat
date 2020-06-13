//
//  StartViewController.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 11/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class StartViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!
    
    private var locationManager: CLLocationManager?
    private var hasLoadedMap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: Set Up

extension StartViewController {
    private func setUp() {
        setUpMap()
    }
    
    private func setUpMap() {
        mapView.camera = .athens
        mapView.delegate = self
    }
    
    private func setUpLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
}

// MARK: GMSMapViewDelegate

extension StartViewController: GMSMapViewDelegate {
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        guard !hasLoadedMap else { return }
        hasLoadedMap = true
        setUpLocationManager()
    }
}

// MARK: CLLocationManagerDelegate

extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        mapView.isMyLocationEnabled = true
        if let lastKnown = locationManager?.location {
            mapView.centerTo(lastKnown)
        }
        locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastOne = locations.last else { return }
        mapView.centerTo(lastOne)
    }
}
