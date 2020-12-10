//
//  TimelyCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import UIKit
import AlamofireImage

class TimelyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: TitleLabel!

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var descLabel: TitleLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(model : Hourly){
        if let date = model.dt{
            titleLabel.text = date.toDateString(format: "ha")
        }
        if let temp = model.temp?.tempDegrees(){
            descLabel.text = temp 
        }

        if let weatherArray = model.weather,let currentModel = weatherArray.first,let iconName = currentModel.icon{
            let urlString = Environment.imageURL.absoluteString + "\(iconName)@2x.png"
            guard let imageURL = URL(string: urlString) else { return  }
            imgView.af_setImage(withURL: imageURL)
        }



    }
}
