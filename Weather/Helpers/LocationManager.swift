//
//  LocationManager.swift
//  Weather
//
//  Created by Олег Савельев on 14.06.2021.
//

import Foundation
import CoreLocation

class LocationManager {
    func getCoordinates(for city: String, completion: @escaping (CLLocationCoordinate2D?, NSError?) -> Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            if let placemark = placemarks?[0] {
                guard let location = placemark.location else { return }
                completion(location.coordinate, nil)
                return
            }
            if let error = error {
                print(error.localizedDescription)
                
            }
            completion(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
        
    }
}
