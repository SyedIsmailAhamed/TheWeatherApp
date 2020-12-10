//
//  DetailsTableViewCell.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {


    @IBOutlet weak var sunRiseTitleLabel: TitleLabel!
    @IBOutlet weak var sunsetTitleLabel: TitleLabel!
    @IBOutlet weak var humidityTitleLabel: TitleLabel!
    @IBOutlet weak var chanceofRainTitleLabel: TitleLabel!
    @IBOutlet weak var windSpeedTitleLabel: TitleLabel!
    @IBOutlet weak var pressureTitleLabel: TitleLabel!
    @IBOutlet weak var tempMorningTitleLabel: TitleLabel!
    @IBOutlet weak var tempDayTitleLabel: TitleLabel!
    @IBOutlet weak var tempEveningTitleLabel: TitleLabel!
    @IBOutlet weak var tempNightTitleLabel: TitleLabel!


    @IBOutlet weak var sunRiseLabel: DetailsLabel!
    @IBOutlet weak var sunsetLabel: DetailsLabel!
    @IBOutlet weak var humidityLabel: DetailsLabel!
    @IBOutlet weak var chanceofRainLabel: DetailsLabel!
    @IBOutlet weak var windSpeedLabel: DetailsLabel!
    @IBOutlet weak var pressureLabel: DetailsLabel!
    @IBOutlet weak var tempMorningLabel: DetailsLabel!
    @IBOutlet weak var tempDayLabel: DetailsLabel!
    @IBOutlet weak var tempEveningLabel: DetailsLabel!
    @IBOutlet weak var tempNightLabel: DetailsLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTitleLabels()
    }
    func setTitleLabels(){
        sunRiseTitleLabel.text = "Sunrise".capitalized
        sunsetTitleLabel.text = "Sunset".capitalized
        humidityTitleLabel.text = "Humidity".capitalized
        chanceofRainTitleLabel.text = "chance of rain".capitalized
        windSpeedTitleLabel.text = "wind speed".capitalized
        pressureTitleLabel.text = "pressure".capitalized
        tempMorningTitleLabel.text = "Morning".capitalized
        tempDayTitleLabel.text = "Day".capitalized
        tempEveningTitleLabel.text = "Evening".capitalized
        tempNightTitleLabel.text = "Night".capitalized

    }

    func loadData(model:Daily){
        sunRiseLabel.text = model.sunrise?.toDateString(format: "hh:mm a")
        sunsetLabel.text = model.sunset?.toDateString(format: "hh:mm a")
        humidityLabel.text = model.humidity?.toString()
        chanceofRainLabel.text = model.rain?.toPercentage() ?? "0%"
        windSpeedLabel.text = (model.wind_speed?.toString() ?? "") + " mph"
        pressureLabel.text = (model.pressure?.toString() ?? "") + " hPa"
        tempMorningLabel.text = model.temp?.morn?.tempDegrees()
        tempDayLabel.text = model.temp?.day?.tempDegrees()
        tempEveningLabel.text = model.temp?.eve?.tempDegrees()
        tempNightLabel.text = model.temp?.night?.tempDegrees()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
