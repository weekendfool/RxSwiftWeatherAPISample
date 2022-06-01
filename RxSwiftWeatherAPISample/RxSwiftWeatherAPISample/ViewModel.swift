//
//  ViewModel.swift
//  RxSwiftWeatherAPISample
//
//  Created by Oh!ara on 2022/05/29.
//

import Foundation
import RxSwift
import RxCocoa

protocol RxSwiftWeatherAPIViewModelInput {
    var textFieldCityName: PublishRelay<String> { get }
    var isTappedButton: PublishRelay<Void> { get }
    
    var model: WeatherModel { get }
}


protocol RxSwiftWeatherAPIViewModelOutput {
    var weather: Signal<String> { get }
    var place: Signal<String> { get }
    var temperture: Signal<String> { get }
}

protocol RxSwiftWeatherAPIViewModelType {
    var input: RxSwiftWeatherAPIViewModelInput { get }
    var output: RxSwiftWeatherAPIViewModelOutput { get }
}


class RxSwiftWeatherAPIViewModel: RxSwiftWeatherAPIViewModelInput, RxSwiftWeatherAPIViewModelOutput, RxSwiftWeatherAPIViewModelType {
    
    var input: RxSwiftWeatherAPIViewModelInput { return self }
    var output: RxSwiftWeatherAPIViewModelOutput { return self }
    
    private let disposeBag = DisposeBag()
    private let weatherData = PublishRelay<String>()
    private var cityName = BehaviorRelay<String>(value: "")
    var name = "東京"
    
    // Input
    var textFieldCityName = PublishRelay<String>()
    var isTappedButton = PublishRelay<Void>()
    var model = WeatherModel()
    
    
    // output
    var weather: Signal<String>
    var place: Signal<String>
    var temperture: Signal<String>
    
    init() {
        
        // output
        
        weather = weatherData.map { weather in
            String(weather)
        }
        .asSignal(onErrorSignalWith: .empty())
        
        place = weatherData.map { weather in
            String(weather)
        }
        .asSignal(onErrorSignalWith: .empty())
        
        temperture = weatherData.map { weather in
            String(weather)
        }
        .asSignal(onErrorSignalWith: .empty())
        

        // input
        // tapされた時の動作
        isTappedButton.map { [weak self] _ in
            // api通信を起動
//            guard let self = self else { return }
//            guard let city = self?.cityName else { return }
            print("ok")
//            let city = String(self?.cityName)
            self?.model.fetchWeather(cityName: self!.name)
            return "sun"
        }
        .bind(to: weatherData)
        .disposed(by: disposeBag)
 
        textFieldCityName.map{ [weak self] text in
            self?.name = text
        }
       
        
        
       
    }
   
    
    
}

