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
//    private let city = BehaviorRelay<String>(value: "")
    // 返却されたデータ
    private var returnCityName = BehaviorRelay<String>(value: "")
    private var returnWeather = BehaviorRelay<String>(value: "")
    private var returnTemperture = BehaviorRelay<String>(value: "")
    var name = ""
    
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
        
        weather = returnWeather.map { weather in
            String(weather)
        }
        .asSignal(onErrorSignalWith: .empty())
        
        place = returnCityName.map { city in
            String(city)
        }
        .asSignal(onErrorSignalWith: .empty())
        
        temperture = returnTemperture.map { temperture in
            String(temperture)
        }
        .asSignal(onErrorSignalWith: .empty())
        

        // input
        // tapされた時の動作
        isTappedButton.map { [weak self] in
            // api通信を起動
            self?.model.fetchWeather(cityName: self?.name ?? "")
            
            return self?.model.city ?? ""
        }
        .bind(to: returnCityName)
        .disposed(by: disposeBag)
        
        isTappedButton.map { [weak self] in
            // api通信を起動
            self?.model.fetchWeather(cityName: self?.name ?? "")
            
            return self?.model.weather ?? ""
        }
        .bind(to: returnWeather)
        .disposed(by: disposeBag)
        
        isTappedButton.map { [weak self] in
            // api通信を起動
            self?.model.fetchWeather(cityName: self?.name ?? "")
            
            return self?.model.temperature ?? ""
        }
        .bind(to: returnTemperture)
        .disposed(by: disposeBag)
 
        textFieldCityName.map{ [weak self] text in
            self?.name = text
        }
       
        
        
        
        
       
    }
   
    
    
}

