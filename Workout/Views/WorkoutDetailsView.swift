//
//  WorkoutDetailsView.swift
//  Workout
//
//  Created by blind heitz nathan on 03/03/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct WorkoutDetailsView: View {
    
    @State var locationManager = CLLocationManager()
    var workout: Workout
    
    var body: some View {
        
        let min: String = workout.time.min < 10 ? "0\(workout.time.min)" : "\(workout.time.min)"
        let sec: String = workout.time.sec < 10 ? "0\(workout.time.sec)" : "\(workout.time.sec)"
        let mili: String = workout.time.mili < 10 ? "0\(workout.time.mili)" : "\(workout.time.mili)"
        
        ZStack {
            VStack{
                VStack {
                    HStack {
                        Image(systemName: workout.categogy.icon)
                        Text(workout.getFormattedDate())
                    }
                    MapView(workout: workout)
                }
                .navigationTitle("Details")
                HStack {
                    info(titre: "Distance", text: "\(String(format: "%.1f", workout.perform.distance)) m")
                    Divider()
                    info(titre: "Time", text: "\(min):\(sec):\(mili)")
                    Divider()
                    info(titre: "Speed", text: "\(String(format: "%.1f", workout.perform.speed)) m/s")
                }
                .frame(height: 100)
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    var workout: Workout
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 15, longitude: 17), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: workout.points[0].coordinate)
        let p2 = MKPlacemark(coordinate: workout.points[1].coordinate)
        
        let requests = MKDirections.Request()
        requests.source = MKMapItem(placemark: p1)
        requests.destination = MKMapItem(placemark: p2)
        requests.transportType = .automobile
        
        let directions = MKDirections(request: requests)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([p1, p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
        }
        
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .orange
            renderer.lineWidth = 7
            return renderer
        }
    }
}

struct info : View {
    
    var titre : String
    var text : String
    
    var body: some View {
        VStack {
            Text(titre)
                .font(.custom("Avenir", size: 20))
                .foregroundColor(Color.black)
                .padding(.bottom, 1)
            Text(text)
                .font(.custom("Avenir", size: 22) .bold())
                .foregroundColor(Color.black)
                .padding(.top, 1)
                .padding( .trailing , 10 )
                .padding( .leading, 10)
        }
    }
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailsView(workout: Workout.testData[0])
    }
}
