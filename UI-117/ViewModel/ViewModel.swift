//
//  ViewModel.swift
//  UI-117
//
//  Created by にゃんにゃん丸 on 2021/02/02.
//

import SwiftUI
import MapKit
import CoreLocation

class ViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    
    @Published var mapview = MKMapView()
    @Published var region : MKCoordinateRegion!
    @Published var permissonDenid = false
   
    @Published var maptype : MKMapType = .standard
    
    @Published var text = ""
    @Published var places : [Place] = []
    @Published var show = false
    
  
    
    func updatemaptype(){
        
        if maptype == .standard{
            maptype = .hybrid
            mapview.mapType = maptype
            
        }
        else{
            
            maptype = .standard
            mapview.mapType = maptype
        }
        
    }
    
    func foucusLocation(){
        
        
        guard let _ = region else{return}
        
        mapview.setRegion(region, animated: true)
        mapview.setVisibleMapRect(mapview.visibleMapRect, animated: true)
    }
    
    func searchQuery(){
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = text
        MKLocalSearch(request: request).start { (responce, _) in
            guard let result = responce else {return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place in
                return Place(placemark: item.placemark)
            })
            
            
        }
        
        
    }
    
    func selectplace(place : Place){
        text = ""
        guard let coordinate = place.placemark.location?.coordinate else {return}
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No name"
        mapview.removeAnnotations(mapview.annotations)
        mapview.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapview.setRegion(coordinateRegion, animated: true)
        mapview.setVisibleMapRect(mapview.visibleMapRect, animated: true)
        
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .denied:permissonDenid.toggle()
        case.notDetermined: manager.requestWhenInUseAuthorization()
        case.authorizedWhenInUse:manager.requestLocation()
        default:()
            
        }
        
    
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        self.mapview.setRegion(self.region, animated: true)
        self.mapview.setVisibleMapRect(self.mapview.visibleMapRect, animated: true)
        
        
        
    }
    
}


