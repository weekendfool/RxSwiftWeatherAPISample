//
//  WeatherDataModel.swift
//  RxSwiftWeatherAPISample
//
//  Created by Oh!ara on 2022/05/31.
//

import Foundation

struct WeatherDataModel {
    
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var coditionName: String {
        
    }
}
