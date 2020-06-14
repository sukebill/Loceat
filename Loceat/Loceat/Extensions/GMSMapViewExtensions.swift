//
//  GMSMapViewExtensions.swift
//  Loceat
//
//  Created by Vassilis Alexandrof on 11/6/20.
//  Copyright © 2020 VA. All rights reserved.
//

import GoogleMaps

extension GMSCameraPosition {
    static let athens: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 37.97945,
                                                                    longitude: 23.71622,
                                                                    zoom: 17.0)
}

extension GMSMapView {
    func centerToMyLocation() {
        guard let myLocation = myLocation else { return }
        let camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate,
                                              zoom: self.camera.zoom)
        animate(to: camera)
    }
    
    func centerTo(_ location: CLLocation) {
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate,
                                              zoom: self.camera.zoom)
        animate(to: camera)
    }
    
    func addFakeCurrentLocationMarker() -> GMSMarker {
        let markerView = UIView()
        markerView.frame.size = CGSize(width: 1, height: 1)
        markerView.backgroundColor = .black
        markerView.clipsToBounds = true
        let imageView = UIImageView(frame: markerView.bounds)
        imageView.image = nil
        markerView.addSubview(imageView)
        let marker = GMSMarker()
        marker.iconView = markerView
        marker.isTappable = false
        marker.map = self
        selectedMarker = marker
        return marker
    }
}
