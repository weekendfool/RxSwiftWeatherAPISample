//
//  Model.swift
//  RxSwiftWeatherAPISample
//
//  Created by Oh!ara on 2022/05/29.
//

import Foundation


class WeatherModel {
    
    // アクセスするためのURL
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=26879492e3ebde403fb18588142381cc&units=metric"
    
    // どこの都市にするか
    func fetchWeather(cityName: String) {
        // 取得したい都市の天気にアクセスするURL
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        // アクセス
        performRecquest(with: urlString)
    }
    
    func performRecquest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.paresJSON(safeData)
                }
            }
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?
    
}
