//
//  HomeHeaderView.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var temperatureLabel: TemperatureLabel!
    @IBOutlet weak var weatherLabel: HeaderTitleLabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var citylabel: CityLabel!
    @IBOutlet weak var lowLabel: UILabel!

    override class func awakeFromNib() {
    }

    func loadData(weatherModel : HeaderModelable){
        citylabel.text = weatherModel.cityTitle
        weatherLabel.text = weatherModel.weatherTitle
        temperatureLabel.text = weatherModel.temperature.toCelsius()
        highLabel.text = "H:" + weatherModel.maxTemp.toCelsius()
        lowLabel.text = "L:" + weatherModel.minTemp.toCelsius()
    }


}
