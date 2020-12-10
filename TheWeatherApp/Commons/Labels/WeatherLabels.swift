//
//  WeatherLabels.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import Foundation
import UIKit

@IBDesignable class HeaderTitleLabel : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        font = WeatherFonts.sectionHeaderTitleFont
        textColor = Colors.LabelColors.headerColor
    }
}
@IBDesignable class TitleLabel : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        font = WeatherFonts.titleLabelFont
        textColor = Colors.LabelColors.headerColor
    }
}
@IBDesignable class CityLabel : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        font = WeatherFonts.sectionHeaderTitleFont
        textColor = Colors.LabelColors.headerColor
    }
}

@IBDesignable class TemperatureLabel : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.appFont(.lgc, typeFace: .regular, size: 55)
        textColor = Colors.LabelColors.headerColor
    }
}
