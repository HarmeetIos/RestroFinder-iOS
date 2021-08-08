//
//  MapController.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-08-07.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: AbstractViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    private var business: Businesses?
    private var locationManager:CLLocationManager!
    private var latitude: Double?
    private var longitude: Double?
    class func controlWith(business: Businesses) -> MapViewController {
        let control = self.control as! MapViewController
        control.business = business
        return control
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
       super.viewDidLoad()
        self.initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false);
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Init Views
    func initViews() {
        self.initLocation()
        self.mapView.delegate = self
        
    }
 
    // MARK: Init CLLocatiion manager to fetch user location
    private func initLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let authStatus = CLLocationManager.authorizationStatus()
        checkLocationAuthorizationStatus(status: authStatus)
    }
    
    // MARK: checkLocationAuthorizationStatus
    func checkLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            showLocationDisabledPopUp()
        case .restricted:
            UIAlertController.showAlert("Error", "Access to Location Services is Restricted", in: self)
        @unknown default:
            fatalError()
        }
    }
    
    // MARK: - Show alert while location is disabled
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background location access disabled", message: "We need your location access to get restaurants near you.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        alertController.addAction(openAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK- Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            guard latitude == nil && longitude == nil else { return }
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            let sourceLocation = CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
            let destinationLocation = CLLocationCoordinate2D(latitude: business?.coordinates?.latitude ?? 0.0, longitude: business?.coordinates?.longitude ?? 0.0)
            self.navigateToDestination(source: sourceLocation, dest: destinationLocation)
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showAlert(title: "Error", message: error.localizedDescription)
    }
    
    // MARK: - Navigate to resto location
    func navigateToDestination(source:CLLocationCoordinate2D, dest: CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: source, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: dest, addressDictionary: nil)
        
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        
        let sourceAnotation = MKPointAnnotation()
        sourceAnotation.title = "Your location"
        sourceAnotation.subtitle = "The Capital of INIDA"
        if let location = sourcePlaceMark.location {
            sourceAnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
         destinationAnotation.title = business?.alias ?? ""
        if let location = destinationPlaceMark.location {
            destinationAnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
    
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("ERROR FOUND : \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            
        }
    }
    
    //MARK:- Actions
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

// MARK: - MKMapViewDelegate delegates
extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rendere = MKPolylineRenderer(overlay: overlay)
        rendere.lineWidth = 5
        rendere.strokeColor = .systemBlue
        
        return rendere
    }
}
