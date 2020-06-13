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
    @IBOutlet var bottomView: UIView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var myLocationView: UIView!
    @IBOutlet var continueButton: UIButton!
    
    private var locationManager: CLLocationManager?
    private var hasLoadedMap: Bool = false
    private var myLocationFakeMarker: GMSMarker?
    private var hasCenteredToLocationAtStartup: Bool = false
    
    deinit {
       mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let update = change,
            let myLocation = update[NSKeyValueChangeKey.newKey] as? CLLocation else { return }
        myLocationFakeMarker?.position = myLocation.coordinate
        GMSGeocoder().reverseGeocodeCoordinate(myLocation.coordinate) { [weak addressLabel] (response, error) in
            addressLabel?.text = response?.firstResult()?.lines?.first ?? "N/A"
        }
        guard !hasCenteredToLocationAtStartup else { return }
        hasCenteredToLocationAtStartup = true
        mapView.centerTo(myLocation)
    }
    
    @IBAction func onContinueTapped(_ sender: Any) {
    }
    
    @IBAction func onMyLocationTapped(_ sender: Any) {
        mapView.centerToMyLocation()
    }
}

// MARK: Set Up

extension StartViewController {
    private func setUp() {
        setUpMap()
        setUpBottomView()
        setUpMyLocationButton()
    }
    
    private func setUpMap() {
        mapView.camera = .athens
        mapView.delegate = self
        myLocationFakeMarker =  mapView.addFakeCurrentLocationMarker()
        mapView.addObserver(self,
                            forKeyPath: "myLocation",
                            options: NSKeyValueObservingOptions.new,
                            context: nil)

    }
    
    private func setUpBottomView() {
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.addShadow(UIColor.black.withAlphaComponent(0.2))
        continueButton.layer.cornerRadius = 8
    }
    
    private func setUpMyLocationButton() {
        myLocationView.layer.cornerRadius = 8
        myLocationView.addShadow(UIColor.black.withAlphaComponent(0.2))
        myLocationView.layer.shouldRasterize = true
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
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIImageView(image: UIImage(named: "Place"))
    }
}

// MARK: CLLocationManagerDelegate

extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        mapView.isMyLocationEnabled = true
        myLocationView.isHidden = false
    }
}
