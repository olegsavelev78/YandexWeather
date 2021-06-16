//
//  Weather.swift
//  Weather
//
//  Created by Олег Савельев on 13.06.2021.
//

import Foundation

struct Weather {
    var cityName: String
    let temp: Int
    var tempString: String {
        return setTemp(temp: temp)
        
    }
    let feelsLike: Int
    var feelsLikeString: String {
        return "Ощущается как \(setTemp(temp: feelsLike))"
    }
    let minTemp: Int
    var minTempString: String{
        return "Ночью \(setTemp(temp:minTemp))"
    }
    let maxTemp: Int
    var maxTempString: String{
        return "Днем \(setTemp(temp:maxTemp))"
    }
    
    let wind: Double
    var windString: String {
        return "Скорость ветра \(wind) м/с, \(windDirString)"
    }
    
    let windDir: String
    var windDirString: String {
        switch windDir {
        case "n": return "С"
        case "nw": return "СЗ"
        case "s": return "Ю"
        case "sw": return "ЮЗ"
        case "w": return "З"
        default: return ""
        }
    }
    
    let condition: String
    var conditions: String {
        switch condition {
        case "clear": return "ясно"
        case "partly-cloudy": return "малооблачно"
        case "cloudy": return "облачно с прояснениями"
        case "overcast": return "пасмурно"
        case "drizzle": return "морось"
        case "light-rain": return "небольшой дождь"
        case "rain": return "дождь"
        case "moderate-rain": return "умеренно сильный дождь"
        case "heavy-rain": return "сильный дождь"
        case "continuous-heavy-rain": return "длительный сильный дождь"
        case "showers": return "ливень"
        case "wet-snow": return "дождь со снегом"
        case "light-snow": return "небольшой снег"
        case "snow": return "снег"
        case "snow-showers": return "снегопад"
        case "hail": return "град"
        case "thunderstorm": return "гроза"
        case "thunderstorm-with-rain": return "дождь с грозой"
        case "thunderstorm-with-hail": return "гроза с градом"
        default: return ""
        }
    }
    let humidity: Int
    var humidityString: String {
        return "Влажность \(humidity)%"
    }
    let pressure: Int
    var pressureString: String {
        return "Давление \(pressure) мм рт.ст."
    }
    
    var icon: String
    
    //MARK: -Init
    init?(weatherDate: WeatherData) {
        cityName = weatherDate.geo_object.locality.name
        icon = weatherDate.fact.icon
        temp = weatherDate.fact.temp
        condition = weatherDate.fact.condition
        feelsLike = weatherDate.fact.feels_like
        minTemp = weatherDate.forecasts[0].parts.day.temp_min
        maxTemp = weatherDate.forecasts[0].parts.day.temp_max
        wind = weatherDate.fact.wind_speed
        windDir = weatherDate.fact.wind_dir
        humidity = weatherDate.fact.humidity
        pressure = weatherDate.fact.pressure_mm
    }
    
    func setTemp(temp: Int) -> String {
        if temp > 0 {
            return "+\(temp) C°"
        } else { return "-\(temp) C°" }
    }
    
}
