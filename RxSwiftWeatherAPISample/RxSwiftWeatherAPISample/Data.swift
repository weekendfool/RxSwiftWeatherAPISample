//
//  File.swift
//  RxSwiftWeatherAPISample
//
//  Created by Oh!ara on 2022/05/31.
//

import Foundation
import CoreImage

struct Data: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
