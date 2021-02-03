//
//  MapView.swift
//  UI-117
//
//  Created by にゃんにゃん丸 on 2021/02/02.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    
    
    @EnvironmentObject var model : ViewModel
    
    func makeCoordinator() -> Coordinator {
        
        return MapView.Coordinator()

        
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = model.mapview
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject,MKMapViewDelegate{
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self){return nil}
            else{
                
                let pinanotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin View")
                pinanotation.tintColor = .purple
                pinanotation.animatesDrop = true
                pinanotation.canShowCallout = true
                return pinanotation
                
                
                
            }
        }
        
        
        
    }
    
    
}

