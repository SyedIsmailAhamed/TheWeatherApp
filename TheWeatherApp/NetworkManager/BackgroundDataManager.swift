//
//  BackgroundDataManager.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import Foundation
import CoreLocation

class BackgroundDataManager {
    private static var sharedInstance: BackgroundDataManager {
        return BackgroundDataManager()
    }
    class func shared() -> BackgroundDataManager {
        return sharedInstance
    }

    func fetchDatainBackground(){
        DispatchQueue.global(qos: .background).async {
            self.fetchWeatherData { (status) in
                if status{
                    DispatchQueue.main.async {
                        print("This is run on the main queue, after the previous code in outer block")
                    }
                }
            }
        }
    }


    func fetchWeatherData(completionhandler: @escaping ((Bool)->())) {
        if let currentLocation = Commons.currentLocation {
            HomeService.getWeatherData(location: currentLocation) { (sender: RequestCallback<HomeWeather>) in
                switch sender {
                case .success(let object):
                    StorageManager.shared().saveData(model: object) { (status) in
                    }
                    completionhandler(true)
                case .failed(let error):
                    switch error {
                    case .gernalError(let message):
                        print("failed to fetch data in background \(message)")
                    default:
                        print("failed to fetch data in background")
                    }
                    completionhandler(false)
                }
            }
        }
    }
}
