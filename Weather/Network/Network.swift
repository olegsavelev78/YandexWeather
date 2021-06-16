//
//  Network.swift
//  Weather
//
//  Created by Олег Савельев on 12.06.2021.
//

import UIKit
import Foundation
import CoreLocation
import SwiftSVG

class Network {
    private var urlY = "https://api.weather.yandex.ru/v2/forecast?lang=ru_RU"
    private let apikey = "c14069a1-8df3-4cb9-9717-712c43d791b3"
    private let HTTPHeader = "X-Yandex-API-Key"
    private let coord = LocationManager()
    static let shared = Network()
    
    
    func getCitesWeather(cities: [String], completion: @escaping (Weather) -> Void){
        for city in cities {
            coord.getCoordinates(for: city) { coordinate, error in
                guard let coordinate = coordinate else { return }
                let urlString = self.urlY + "&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
                guard let url = URL(string: urlString) else { return }
                let session = URLSession(configuration: .default)
                
                var request = URLRequest(url: url)
                request.addValue(self.apikey, forHTTPHeaderField: self.HTTPHeader)
                
                session.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let weather = self.parseJSON(withData: data){
                            completion(weather)
                        }
                    }
                }.resume()
            }
        }
    }
    
    private func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do{
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherDate: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

    
}
