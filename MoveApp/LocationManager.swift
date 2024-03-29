//
//  LocationManager.swift
//  MoveApp
//
//  Created by asmaa gamal  on 14/03/2024.
//

import Foundation
import CoreLocation
class LocationManager:NSObject, ObservableObject, CLLocationManagerDelegate{
    private var locationManger = CLLocationManager()
    @Published var location: CLLocation?
    @Published var latitude:Double?
    @Published var longitude:Double?
    @Published var address:String?
    override init(){
        super.init()
        self.locationManger.delegate = self
        self.locationManger.requestWhenInUseAuthorization()
        self.locationManger.startUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocation = locations.last {
            self.location = myLocation
        }
    }
    
    
    
    let geocoder = CLGeocoder()
    
    
    func geocodeAddress(address:String) {
           geocoder.geocodeAddressString(address) { placemarks, error in
               if let error = error {
                   print("Geocoding error: \(error.localizedDescription)")
                   return
               }
               if let placemark = placemarks?.first {
                   self.latitude = placemark.location?.coordinate.latitude ?? 0
                   self.longitude = placemark.location?.coordinate.longitude ?? 0
                   
               }
           }
       }
       
    func reverseGeocodeLocation() {
//        if let latitude = Double(location?.coordinate.latitude ?? 0), let longitude = Double(location?.coordinate.longitude ?? 0) {
        guard let location = self.location else { return  }
               geocoder.reverseGeocodeLocation(location) { placemarks, error in
                   if let error = error {
                       print("Reverse geocoding error: \(error.localizedDescription)")
                       return
                   }
                   if let placemark = placemarks?.first {
                       self.address = "\(placemark)"
                   }
               }
           }
//       }
    
    
    
}
