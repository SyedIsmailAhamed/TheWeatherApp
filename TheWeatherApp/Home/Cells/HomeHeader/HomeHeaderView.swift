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
    @IBOutlet weak var unitsButton: UIButton!

    var didSelectUnitsButton: ((Bool)->())?

    override  func awakeFromNib() {
        unitsButton.setTitle("C° / F°", for: .normal)
    }

    @IBAction func unitsButtonTapped(_ sender: Any) {
        if let buttonTapped = didSelectUnitsButton{
            buttonTapped(true)
        }
    }


    func loadData(weatherModel : HeaderModelable){
        citylabel.text = weatherModel.cityTitle
        weatherLabel.text = weatherModel.weatherTitle
        temperatureLabel.text = weatherModel.temperature.tempDegrees()
        highLabel.text = "H:" + weatherModel.maxTemp.tempDegrees()
        lowLabel.text = "L:" + weatherModel.minTemp.tempDegrees()
    }


}
