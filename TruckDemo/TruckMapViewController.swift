//
//  TruckMapViewController.swift
//  TruckDemo
//
//  Created by Aaditya Verma on 26/12/21.
//

import UIKit
import GoogleMaps
class TruckMapViewController: UIViewController {
    var viewModel : TruckMapViewModel?
    var bounds : GMSCoordinateBounds!
    var mapView : GMSMapView!
    
    override func viewDidLoad() {
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        self.title = "Trucks"
        setUpGoogleMaps()
        navigationItem.hidesBackButton = true
        placeTruckMarkers()
        self.setRightButtons()
    }
    
    open func setRightButtons() {
        let listButton = UIBarButtonItem(image: UIImage(named: "list"), style: .plain,
                                         target: self, action:  #selector(backButtonPressed))
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refresh"), style: .plain,
                                        target: self, action: #selector(refreshButtonPressed))
        navigationItem.rightBarButtonItems = [listButton,refreshButton]
    }
    
    fileprivate func setUpGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 2)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
    }
    
    fileprivate func placeTruckMarkers() {
        var truckLocations : [CLLocationCoordinate2D] = []
        for truckData in (viewModel?.trucklistData)! {
            let location = CLLocationCoordinate2D(latitude: (truckData.lastWaypoint?.lat)!, longitude: (truckData.lastWaypoint?.lng)!)
            let marker = GMSMarker()
            if truckData.lastRunningState?.truckRunningState == 0 {
                marker.icon = UIImage(named: "truckBlue")
            } else if truckData.lastRunningState?.truckRunningState == 1 {
                marker.icon = UIImage(named: "truckGreen")
            } else {
                marker.icon = UIImage(named: "truckRed")
            }
            marker.position = location
            truckLocations.append(location)
            marker.map = mapView
        }
        bounds = GMSCoordinateBounds(coordinate: truckLocations.first!, coordinate: truckLocations.last!)
        for location in truckLocations {
            bounds = bounds.includingCoordinate(location)
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshButtonPressed() {
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
    }
}
