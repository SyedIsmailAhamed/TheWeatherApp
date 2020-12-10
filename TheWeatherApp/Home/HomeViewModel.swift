//
//  HomeViewModel.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import Foundation
import CoreLocation
import UserNotifications

class HomeViewModel {

    var weatherModel: HomeWeather?
    init() {

    }

    func fetchWeatherData(location: CLLocation, completionHandler: @escaping ((Bool) -> ())) {
        if !Connectivity.isConnectedToInternet {
            //retun cached data
            let savedDataArray = StorageManager.shared().fetchData(with: HomeWeather.self)
            if savedDataArray.count > 0 {
                self.weatherModel = savedDataArray[0]
                completionHandler(true)
            }
        } else {
            Commons.showActivityIndicator()
            HomeService.getWeatherData(location: location) { [weak self] (sender: RequestCallback<HomeWeather>) in
                guard let self = self else { return completionHandler(false) }
                Commons.hideActivityIndicator()
                switch sender {
                case .success(let object):
                    self.weatherModel = object
                    if let currentWeather = self.weatherModel {
                        StorageManager.shared().saveData(model: currentWeather) { (status) in
                            let savedObj = StorageManager.shared().fetchData(with: HomeWeather.self)
                            print("savedObj count \(savedObj.count)")
                            self.showAlert()
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

    func showAlert(){
        let notificationCenter = UNUserNotificationCenter.current()

        let notification = UNMutableNotificationContent()
        notification.title = "TheWeather App"
        if let weatherArr = self.weatherModel?.current?.weather,weatherArr.count>0,let text =  weatherArr[0].desc{
            let currentTemp = self.weatherModel?.current?.temp?.tempDegrees() ?? ""
            notification.body = "\(text) today, its currently \(currentTemp)"
        }
        notification.categoryIdentifier = "alarm"
        notification.sound = UNNotificationSound.default


        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: nil)

        notificationCenter.add(notificationRequest)
    }
   
    func numberofRows()->Int{
        let daysCount = weatherModel?.daily?.count ?? 0
         return daysCount
    }
    func getDaysModel(idxPath:IndexPath)->Daily?{
        return weatherModel?.daily?[idxPath.row]
    }

}
