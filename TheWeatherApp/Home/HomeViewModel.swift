//
//  HomeViewModel.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import Foundation
import CoreLocation

class HomeViewModel {

    var weatherModel : HomeWeather?
    init() {

    }

    func fetchWeatherData(location: CLLocation,completionHandler: @escaping ((Bool) -> ())) {
        Commons.showActivityIndicator()
        HomeService.getWeatherData(location: location) {[weak self] (sender: RequestCallback<HomeWeather>) in
            guard let self = self else {return completionHandler(false)}
            Commons.hideActivityIndicator()
            switch sender {
            case .success(let object):
                self.weatherModel = object
                if let currentWeather = self.weatherModel{
                    StorageManager.shared().saveData(model: currentWeather) { (status) in
                        print("weather data stored to realm")

                        let test = StorageManager.shared().fetchData(with: HomeWeather.self)
                        print("test count \(test.count)")
                    }

                }
                completionHandler(true)
            case .failed(let error):
                switch error {
                case .gernalError(let message):
                    Messages.showMessage(message: message, theme: .error)
                default:
                    Messages.showMessage(message: error.localizedDescription, theme: .error)
                }
                completionHandler(false)
            }
        }
    }

}
