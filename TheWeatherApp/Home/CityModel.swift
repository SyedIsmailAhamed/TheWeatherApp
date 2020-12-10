//
//  CityModel.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import Foundation
import ObjectMapper
import RealmSwift
import Unrealm

struct HomeWeather : Realmable, Mappable,HeaderModelable {
    var maxTemp: Double{
        if let dailyArr = daily, dailyArr.count>0{
            return dailyArr[0].temp?.max ?? 0.0
        }
        return 0.0
    }

    var minTemp: Double{
        if let dailyArr = daily, dailyArr.count>0{
            return dailyArr[0].temp?.min ?? 0.0
        }
        return 0.0
    }


    var cityTitle: String{
        return timezone ?? ""
    }

    var weatherTitle: String{
        if let weatherArr = current?.weather, weatherArr.count>0{
            return weatherArr[0].desc ?? ""
        }else{
            return ""
        }
    }

    var temperature: Double{
        return current?.temp ?? 0.0
    }


    init() {
        
    }

    var lat : Double?
    var lon : Double?
    var timezone : String?
    var timezone_offset : Int?
    var current : Current?
    var hourly : [Hourly]?
    var daily : [Daily]?
    var iD : String = Commons.currentUser?.iD ?? ""

    static func primaryKey() -> String? {
        return "iD"
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        lat <- map["lat"]
        lon <- map["lon"]
        timezone <- map["timezone"]
        timezone_offset <- map["timezone_offset"]
        current <- map["current"]
        hourly <- map["hourly"]
        daily <- map["daily"]
    }

}


struct Current :Realmable, Mappable {


    var dt : Int?
    var sunrise : Int?
    var sunset : Int?
    var temp : Double?
    var feels_like : Double?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var uvi : Int?
    var clouds : Int?
    var visibility : Int?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : [Weather]?

    init?(map: Map) {

    }
    init() {

    }

    mutating func mapping(map: Map) {

        dt <- map["dt"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dew_point <- map["dew_point"]
        uvi <- map["uvi"]
        clouds <- map["clouds"]
        visibility <- map["visibility"]
        wind_speed <- map["wind_speed"]
        wind_deg <- map["wind_deg"]
        weather <- map["weather"]
    }

}
struct Hourly :Realmable, Mappable {
    var dt : Int?
    var temp : Double?
    var feels_like : Double?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var uvi : Int?
    var clouds : Int?
    var visibility : Int?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : [Weather]?
    var pop : Int?

    init?(map: Map) {

    }
    init() {

    }
    mutating func mapping(map: Map) {

        dt <- map["dt"]
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dew_point <- map["dew_point"]
        uvi <- map["uvi"]
        clouds <- map["clouds"]
        visibility <- map["visibility"]
        wind_speed <- map["wind_speed"]
        wind_deg <- map["wind_deg"]
        weather <- map["weather"]
        pop <- map["pop"]
    }

}
struct Daily : Realmable,Mappable,Equatable {
    static func == (lhs: Daily, rhs: Daily) -> Bool {
        lhs.dt == rhs.dt
    }

    var dt : Int?
    var sunrise : Int?
    var sunset : Int?
    var temp : Temperature?
    var feels_like : FeelsLike?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : [Weather]?
    var clouds : Int?
    var pop : Int?
    var rain : Double?
    var uvi : Double?

    init?(map: Map) {

    }
    init() {

    }
    mutating func mapping(map: Map) {

        dt <- map["dt"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dew_point <- map["dew_point"]
        wind_speed <- map["wind_speed"]
        wind_deg <- map["wind_deg"]
        weather <- map["weather"]
        clouds <- map["clouds"]
        pop <- map["pop"]
        uvi <- map["uvi"]
        rain <- map["rain"]

    }

}
extension Daily : HeaderModelable{
    var maxTemp: Double {
        return temp?.max ?? 0.0
    }

    var minTemp: Double {
        return temp?.min ?? 0.0
    }

    var cityTitle: String {
        if let date = dt{
            return date.toDateString(format: "EEEE")
        }
        return ""
    }
    var weatherTitle: String {
        if let weatherArr = weather, weatherArr.count>0{
            return weatherArr[0].desc ?? ""
        }else{
            return ""
        }
    }
    var temperature: Double {
        return temp?.day ?? 0.0
    }
}

struct FeelsLike :Realmable, Mappable {
    var day : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?

    init?(map: Map) {

    }
    init() {

    }
    mutating func mapping(map: Map) {

        day <- map["day"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
    }

}
struct Temperature :Realmable, Mappable {
    var day : Double?
    var min : Double?
    var max : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?

    init?(map: Map) {

    }
    init() {

    }
    mutating func mapping(map: Map) {

        day <- map["day"]
        min <- map["min"]
        max <- map["max"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
    }

}
struct Weather : Realmable,Mappable {
    var id : Int?
    var main : String?
    var desc : String?
    var icon : String?

    init?(map: Map) {

    }
    init() {

    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        desc <- map["description"]
        icon <- map["icon"]
    }

}
