//
//  ViewModel2.swift
//  RxSwiftWeatherAPISample
//
//  Created by Oh!ara on 2022/06/09.
//

import Foundation
import RxSwift
import RxCocoa


protocol ViewModel2Input {
    var textFieldCityName: Driver<String> { get }
    var isTappedButton: Signal<Void> { get }
}

protocol ViewModel2Output {
    var weather: Driver<String> { get }
    var place: Driver<String> { get }
    var temperture: Driver<String> { get }
}

protocol ViewModel2Type {
    var input: ViewModel2Input { get }
    var output: ViewModel2Output{ get }
}

class ViewModel2: ViewModel2Type, ViewModel2Input, ViewModel2Output {
    var input: ViewModel2Input { return self }
    var output: ViewModel2Output { return self }
    
    // input
    var textFieldCityName: Driver<String>
    var isTappedButton: Signal<Void>
    
    // output
    var weather: Driver<String>
    var place: Driver<String>
    var temperture: Driver<String>
    
    init(text: Driver<String>, tap: Signal<Void>, model: WeatherModel) {
        self.textFieldCityName = text
        self.isTappedButton = tap
        
        let x = textFieldCityName.map { text -> String in
            return String(text)
        }
        
//        weather = isTappedButton.withLatestFrom(x)
//            .flatMapLatest { text in
//                return model.fetchWeather(cityName: text)
//            }
//
        weather = isTappedButton.map{ _ in
            return model.fetchWeather(cityName: String(x))
        }.asDriver(onErrorDriveWith: .empty())
        
        place =
        
        temperture =
    }
    
    
}
