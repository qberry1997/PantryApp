//
//  MapViewController.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/26/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchTxt: UITextField!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        
        loadMap(userLocation)
    }
    
    func loadMap(_ location: CLLocation) {
        let userCoords = location.coordinate
        
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: userCoords, span: span)
        self.map.setRegion(region, animated: true)
    }
    
    @IBAction func searchMap(_ sender: Any) {
        // clear all current annotations
        self.map.removeAnnotations(self.map.annotations)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchTxt.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start {response, _ in
            guard let response = response else{
                return
            }
            var matches:[MKMapItem] = []
            matches = response.mapItems
            for i in 1...matches.count - 1 {
                let place = matches[i].placemark
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = place.location!.coordinate
                annotation.title = place.name
                
                self.map.addAnnotation(annotation)
            }
        }
    }
}
