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
    
    // 各データ
    var city: String?
    var temperature: String?
    var weather: String?
    
    func fetchWeatherCity(cityName: String) -> String {
        // 取得したい都市の天気にアクセスするURL
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        var cityName: String?
        
        // アクセス
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        print("weather: \(weather)")
                        
                        self.city = weather.cityName
                        self.temperature = String(weather.temperature)
                        self.weather = weather.coditionName
                        
                        cityName = weather.cityName
                        return
                    }
                }
            }
            
            task.resume()
        }
        print("cityName: \(cityName)")
        return cityName ?? "#"
    }
    
    func fetchWeatherTemperature(cityName: String) -> String {
        // 取得したい都市の天気にアクセスするURL
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        var temperature: String?
        
        // アクセス
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        print("weather: \(weather)")
                        
                        self.city = weather.cityName
                        self.temperature = String(weather.temperature)
                        self.weather = weather.coditionName
                        
                        temperature = String(weather.temperature)
                        return
                    }
                }
            }
            
            task.resume()
        }
        print("temperature: \(temperature)")
        return temperature ?? "##"
    }
 
    func fetchWeather(cityName: String) -> String {
        // 取得したい都市の天気にアクセスするURL
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        var retrunWeather: String?
        
        // アクセス
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        print("weather: \(weather)")
                        
                        self.city = weather.cityName
                        self.temperature = String(weather.temperature)
                        self.weather = weather.coditionName
                        
                        retrunWeather =  weather.coditionName
                        return
                    }
                }
            }
            
            task.resume()
        }
        
        print("retrunWeather: \(retrunWeather)")
        return retrunWeather ?? "###"
    }

    // どこの都市にするか
    func fetchWeather2(cityName: String)  {
        // 取得したい都市の天気にアクセスするURL
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        // アクセス
        performRecquest(with: urlString)
        
//        return
    }
    
    func performRecquest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        print("weather: \(weather)")
                        
                        self.city = weather.cityName
                        self.temperature = String(weather.temperature)
                        self.weather = weather.coditionName
                        
                        
                        return
                    }
                }
            }
            
            task.resume()
                    
        }
    }
    
    func performRecquest2(with urlString: String, completion: ()-> ()) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        print("weather: \(weather)")
                        
                        self.city = weather.cityName
                        self.temperature = String(weather.temperature)
                        self.weather = weather.coditionName
                        
                        
                        return
                    }
                }
            }
            
            task.resume()
            
            completion()
           
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherDataModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DataModel.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherDataModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            return nil
        }
    }
    
}
