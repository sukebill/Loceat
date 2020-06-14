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
    @IBOutlet var blurr: UIVisualEffectView!
    
    private var locationManager: CLLocationManager?
    private var hasLoadedMap: Bool = false
    private var myLocationFakeMarker: GMSMarker?
    private var hasCenteredToLocationAtStartup: Bool = false
    private var address: GMSAddress?
    
    deinit {
       mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        guard let update = change,
            let myLocation = update[NSKeyValueChangeKey.newKey] as? CLLocation else { return }
        onLocationFound(myLocation.coordinate)
        guard !hasCenteredToLocationAtStartup else { return }
        hasCenteredToLocationAtStartup = true
        mapView.centerTo(myLocation)
    }
    
    @IBAction func onContinueTapped(_ sender: Any) {
        guard let coordinates = myLocationFakeMarker?.position else { return }
        Route.restaurants(address: address,
                          coordinates: coordinates).pushFrom(self)
    }
    
    @IBAction func onMyLocationTapped(_ sender: Any) {
        mapView.centerToMyLocation()
    }
    
    private func onLocationFound(_ location: CLLocationCoordinate2D) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hideLoader()
        }
        myLocationFakeMarker?.position = location
        GMSGeocoder().reverseGeocodeCoordinate(location) { [weak self] (response, error) in
            self?.address = response?.firstResult()
            self?.addressLabel.text = response?.firstResult()?.lines?.first ?? "N/A"
        }
    }
}

// MARK: Set Up

extension StartViewController {
    private func setUp() {
        setUpMap()
        setUpBottomView()
        setUpMyLocationButton()
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus == .denied || authStatus == .restricted else { return }
        onLocationDenied()
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
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus != .denied || authStatus != .restricted else {
            onLocationDenied()
            return
        }
        locationManager?.requestWhenInUseAuthorization()
    }
}

// MARK: Loader

extension StartViewController {
    private func showLoader() {
        blurr.isHidden = false
        blurr.alpha = 1
        Loader.show(to: view)
    }
    
    private func hideLoader() {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurr.alpha = 0
        }) { (_) in
            self.blurr.isHidden = true
        }
        Loader.hide(from: view)
    }
}

// MARK: Location

extension StartViewController {
    private func onLocationDenied() {
        onLocationFound(GMSCameraPosition.athens.target)
        hideLoader()
        myLocationView.isHidden = true
    }
    
    private func onLocationEnabled() {
        showLoader()
        mapView.isMyLocationEnabled = true
        myLocationView.isHidden = false
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
        
        switch status {
        case .denied, .restricted:
            onLocationDenied()
        case .authorizedAlways, .authorizedWhenInUse:
            onLocationEnabled()
        default:
            return
        }
    }
}

extension StartViewController: PreferredNavigationBar {
    var prefersNavigationBarHidden: Bool { true }
}
