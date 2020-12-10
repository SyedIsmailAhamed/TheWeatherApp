//
//  DetailsViewModel.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import Foundation
class DetailsViewModel {
    let selectedDay : Daily?
    let parentModel : HomeWeather?

    init(day:Daily,parentModel : HomeWeather) {
        self.selectedDay = day
        self.parentModel = parentModel
    }
}
