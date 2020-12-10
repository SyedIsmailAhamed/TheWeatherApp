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
    func loadData(weatherModel : HomeWeather){
        citylabel.text = weatherModel.timezone
        if let weatherArr = weatherModel.current?.weather, weatherArr.count>0{
            weatherLabel.text = weatherArr[0].desc
        }
        temperatureLabel.text = weatherModel.current?.temp?.toCelsius().toString()
       // highLabel.text = weatherModel.current.h
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
