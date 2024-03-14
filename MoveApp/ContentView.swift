//
//  ContentView.swift
//  MoveApp
//
//  Created by asmaa gamal  on 14/03/2024.
//

import SwiftUI
import CoreLocation
import MapKit
struct ContentView: View {
  @ObservedObject  var locationManager = LocationManager()
    @State var address:String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            if let location = locationManager.location {
                           Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                
                       } else {
                           Text("Location not available")
                       }
            TextField("address", text: $address)
            Button{
                locationManager.geocodeAddress(address: address)
            }label: {
                Text("search Address")
            }
            if let myLatitude = locationManager.latitude{
                Text("Latitude: \(myLatitude)")
            }
            if let myLongitude = locationManager.longitude{
                Text("longitude: \(myLongitude)")
            }
                     
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
