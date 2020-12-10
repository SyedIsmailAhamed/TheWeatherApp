//
//  HomeService.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

class HomeService {
    static func getWeatherData(response: @escaping RequestCompletionBlock<HomeWeather>.CompletionResponse) {

        let url = Environment.rootURL.absoluteString + "&lat=\(25.3463)&lon=\(55.4209)" + "&exclude=minutely&appid=" + Environment.apiKey
        CoreWebService.sendRequest(requestURL: url, method: .get,paramters: nil,showMessageType: .none, callBack: response)

    }
}
