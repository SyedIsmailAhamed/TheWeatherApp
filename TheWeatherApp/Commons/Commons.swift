//
//  Commons.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import Foundation
import ProgressHUD
import UIKit
import CoreLocation

class Commons {

    // MARK: - Properties
    private static var sharedInstance: Commons = {
        let commons = Commons()
        return commons
    }()

    static var currentUser: User?
    static var currentLocation: CLLocation?
    static var unitesofMeasurement : UnitsofMeasurement?
    static func showActivityIndicator(){
        ProgressHUD.colorHUD = UIColor.color(r: 0, g: 0, b: 0, alpha: 0.5)
        ProgressHUD.show(nil, interaction: false)
    }
    static func hideActivityIndicator(){
        ProgressHUD.dismiss()
    }

    class func shared() -> Commons {
        return sharedInstance
    }
}

enum UnitsofMeasurement {
    case celsius
    case fahrenheit
}
