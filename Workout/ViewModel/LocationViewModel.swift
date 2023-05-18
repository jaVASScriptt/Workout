//
//  MapViewModel.swift
//  Workout
//
//  Created by blind heitz nathan & delmas vassily on 17/03/2022.
//

import SwiftUI
import MapKit
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var permissionDenied = false
    @Published var startPoint: MapLocation = MapLocation(coordinate: CLLocationCoordinate2D(latitude: 20, longitude: 20))
    @Published var distance: Double = 0.0
    
    var timer = Timer()
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func getDistance(_ manager: CLLocationManager) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let firstLoc = CLLocation(latitude: self.startPoint.coordinate.latitude, longitude: self.startPoint.coordinate.longitude)
            self.distance = firstLoc.distance(from: manager.location!)
        }
    }
    
    func pauseGetDistance() {
        timer.invalidate()
    }
    
    func stopGetDistance() {
        distance = 0.0
        timer.invalidate()
    }
}
