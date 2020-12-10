//
//  HomeService.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//
import CoreLocation

class HomeService {
    static func getWeatherData(location: CLLocation,response: @escaping RequestCompletionBlock<HomeWeather>.CompletionResponse) {

        let url = Environment.rootURL.absoluteString + "&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)" + "&exclude=minutely&appid=" + Environment.apiKey
        CoreWebService.sendRequest(requestURL: url, method: .get,paramters: nil,showMessageType: .none, callBack: response)

    }
}
