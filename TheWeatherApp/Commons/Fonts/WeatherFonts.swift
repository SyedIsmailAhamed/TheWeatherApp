//
//  WeatherFonts.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import Foundation
import UIKit


enum FontName: String {
    case sfUI = "SFUIText"
    case lgc = "LouisGeorgeCafe"
}
enum TypeFace: String {
    case bold = "Bold"
    case regular = "Regular"
}
struct WeatherFonts {
    static let sectionHeaderTitleFont = UIFont.appFont(.lgc, typeFace: .regular, size: 18)
    static let titleLabelFont = UIFont.appFont(.lgc, typeFace: .regular, size: 15)
    static let navigationLabelFont = UIFont.appFont(.lgc, typeFace: .bold, size: 20)
    static let temperatureLabel = UIFont.appFont(.lgc, typeFace: .regular, size: 50)

}

extension UIFont {
    static func appFont(_ fontName: FontName, typeFace: TypeFace, size: CGFloat = 13) -> UIFont {
        let updatedFont = fontName
        let updatedTypeFace = typeFace
        if typeFace == .regular && fontName == .lgc{
            let name = updatedFont.rawValue
            let newSize = size
            return UIFont(name: name, size: newSize) ?? systemFont(ofSize: 11.9)
        }else{
            let name = updatedFont.rawValue + "-" + updatedTypeFace.rawValue
            let newSize = size //* LCConstants.fontScaleValue
            return UIFont(name: name, size: newSize) ?? systemFont(ofSize: 11.9)

        }

    }
    func decreaseFontSize(to newSize:CGFloat) -> UIFont {
        let newfont = UIFont(name: self.fontName, size: newSize)
        return newfont!
    }


    var primaryFontSize : CGFloat{
        return 16
    }
}
