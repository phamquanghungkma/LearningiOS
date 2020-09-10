//
//  ViewController.swift
//  UserLocation
//
//  Created by Apple on 9/5/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManger = CLLocationManager()
    let regionInMeters : Double = 10000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkLocationServices()
    }
    
    func setupLocationManager(){
      
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManger.location?.coordinate{
            let region = MKCoordinateRegion.init(center:location,latitudinalMeters: CLLocationDistance(regionInMeters),longitudinalMeters: CLLocationDistance(regionInMeters))
            mapView.setRegion(region, animated: true)
            
        }
        
        
    }
    

    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do map stuff
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManger.startUpdatingLocation()
            break
        case .denied:
            //show alert instructing the user know to turn on permission
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .restricted:
            //show an alert letting them know what's up
            break
        case .authorizedAlways:
            
            break
        }
        
        
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            // seup  out location manager
            setupLocationManager()
            checkLocationAuthorization()
            
            
        }
        else {
            // show alert letting the user know they have turn this on
        }
        
    }

}

extension ViewController: CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return  }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion.init(center:center,latitudinalMeters: regionInMeters,longitudinalMeters:regionInMeters )
        mapView.setRegion(region, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
}

