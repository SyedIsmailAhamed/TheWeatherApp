//
//  Protocols.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import Foundation
import UIKit


protocol Identifiable {
    static var Identifier: String {get}
}

extension UITableViewCell: Identifiable {
    static var Identifier: String { return String(describing: self)}
}

extension UICollectionViewCell: Identifiable {
    static var Identifier: String { return String(describing: self)}
}
extension UITableViewHeaderFooterView: Identifiable {
    static var Identifier: String { return String(describing: self)}
}

protocol HeaderModelable {
    var cityTitle: String {get}
    var weatherTitle: String { get }
    var temperature: Double { get }
    var maxTemp: Double { get }
    var minTemp: Double { get }

}
