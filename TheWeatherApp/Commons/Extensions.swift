//
//  Extensions.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import Foundation
import UIKit
import SwiftMessages

extension Data {
    func toDictionary() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    func toString() -> String {
        let stringValue = String(data: self, encoding: .utf8)!
        return stringValue
    }
}

extension UIColor {
    static func color(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
}

open class Messages: SwiftMessages {
    public static func showMessage(message: String, theme: Theme, duration: Duration = .automatic) {
        var config: SwiftMessages.Config = SwiftMessages.defaultConfig
        config.duration = duration
        SwiftMessages.show(config: config) { () -> UIView in

            let view = MessageView.viewFromNib(layout: .cardView)
            view.button?.isHidden = true
            view.configureTheme(theme)
            view.configureDropShadow()
            var title = "Error"
            switch theme {
                case .success:
                    title  = "Success"
                case .info:
                    title  = "Info"
                case .warning:
                    title  = "Warning"
                default:
                    break
            }
            view.configureContent(title: title, body: message)
            return view
        }
    }
}

extension Double {
    func tempDegrees() -> String {
        let selectedDegrees = Commons.unitesofMeasurement ?? .celsius
        let degreeString = "\u{00B0}"
        switch selectedDegrees {
            case .celsius:
                let result = self - 273.15
                return String(format: "%.0f",result) + degreeString
            case .fahrenheit:
                let result = self * 9/5 - 459.67
                return String(format: "%.0f",result) + degreeString
        }
    }
    
    func toString() -> String {
        return String(format: "%.0f",self)
    }
    func toPercentage()->String{
        let result = self * 100
        return String(format: "%.0f",result) + " %"
    }

    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "HH"

        return dateFormatter.string(from: date)
    }
}

extension Int{
    func toDateString(format:String)->String{
        let unixDate = self
        let date = Date(timeIntervalSince1970: Double(unixDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: date)
        return str
    }

    func toString()->String{
        return String(self)
    }

    
    
}

extension UICollectionView{
    func dequeueCell<T>(identifier: String, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
extension Notification.Name {
    static let latestWeatherDataFetched = Notification.Name("com.syed.TheWeatherApp")
}


