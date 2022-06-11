//
//  ViewController.swift
//  RxSwiftWeatherAPISample
//
//  Created by Oh!ara on 2022/05/29.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    // MARK: - ui
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempertureLabel: UILabel!
    
    // MARK: - 変数
    var rxSwiftWeatherAPIViewModel = RxSwiftWeatherAPIViewModel()
    var weatherModel = WeatherModel()
    
    private var disposeBag = DisposeBag()
    
    
    // MARK: - ライフサイクル

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchTextField.delegate = self
        
//        bind()
        
        bind2()
        
//        weatherModel.fetchWeather(cityName: "tokyo")
    }

    // MARK: - 関数
    
    func bind() {
        print("bind")
        
        // input
        // button
        goButton.rx.tap.asSignal()
            .emit(to: rxSwiftWeatherAPIViewModel.input.isTappedButton)
            .disposed(by: disposeBag)
        
        // textfield
        searchTextField.rx.text.orEmpty.asSignal(onErrorSignalWith: .empty())
            .emit(to: rxSwiftWeatherAPIViewModel.input.textFieldCityName)
            .disposed(by: disposeBag)
        
        // model
        rxSwiftWeatherAPIViewModel.model = weatherModel
        
        // output
        // plaseLabel
        rxSwiftWeatherAPIViewModel.output.weather
            .asObservable()
            .bind(to: weatherLabel.rx.text)
            .disposed(by: disposeBag)
        // weatherLabel
        rxSwiftWeatherAPIViewModel.output.place
            .asObservable()
            .bind(to: placeLabel.rx.text)
            .disposed(by: disposeBag)
        // tempertureLabel
        rxSwiftWeatherAPIViewModel.output.temperture
            .asObservable()
            .bind(to: tempertureLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bind2() {
        // input
        let viewModel2 = ViewModel2(
            text: searchTextField.rx.text.orEmpty.asDriver(),
            tap: goButton.rx.tap.asSignal(),
            model: weatherModel
        )
        
        // output
        viewModel2.output.tapped
            .withLatestFrom(viewModel2.output.weather)
            .asDriver(onErrorDriveWith: .empty())
            .drive(weatherLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel2.output.tapped
            .withLatestFrom(viewModel2.output.place)
            .asDriver(onErrorDriveWith: .empty())
            .drive(placeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel2.output.tapped
            .withLatestFrom(viewModel2.output.temperture)
            .asDriver(onErrorDriveWith: .empty())
            .drive(tempertureLabel.rx.text)
            .disposed(by: disposeBag)

//        viewModel2.output.weather
////            .map { weather in
////                String(weather)
////            }
//            .drive(weatherLabel.rx.text)
//            .disposed(by: disposeBag)
        
//        viewModel2.output.place
////            .map { place in
////                String(place)
////            }
//            .drive(placeLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel2.output.temperture
////            .map { temperture in
////                String(temperture)
////            }
//            .drive(tempertureLabel.rx.text)
//            .disposed(by: disposeBag)
        
        
       
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "何か入力してください"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let city = searchTextField.text {
//            weatherModel.fetchWeather(cityName: city)
//        }
//
//        searchTextField.text = ""
    }
}

