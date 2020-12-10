//
//  DaysTableViewCell.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var maxLabel: TitleLabel!
    @IBOutlet weak var minLabel: TitleLabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData(model : Daily){

        if let date = model.dt{
            titleLabel.text = date.toDateString(format: "EEEE")
        }

        maxLabel.text = model.temp?.max?.toCelsius()
        minLabel.text = model.temp?.min?.toCelsius()

        if let weatherArray = model.weather,let currentModel = weatherArray.first,let iconName = currentModel.icon{
            let urlString = Environment.imageURL.absoluteString + "\(iconName)@2x.png"
            guard let imageURL = URL(string: urlString) else { return  }
            statusImageView.af_setImage(withURL: imageURL)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
