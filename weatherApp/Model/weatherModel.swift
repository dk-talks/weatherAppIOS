//
//  weatherModel.swift
//  weatherApp
//
//  Created by Dinesh Sharma on 20/11/22.
//

import Foundation

struct WeatherModel {
    
    let name: String
    let temp: Double
    let conditionId: Int
    let description: String
    
    var tempString: String {
       return String(format: "%.1f", temp)
        
    }
    
    var conditionImage: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "smoke.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.min"
        }
    }
    
    
}
