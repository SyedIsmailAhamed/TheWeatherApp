//
//  CityModel.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import Foundation
import ObjectMapper

struct HomeWeather : Mappable {
    var lat : Double?
    var lon : Double?
    var timezone : String?
    var timezone_offset : Int?
    var current : Current?
    var hourly : [Hourly]?
    var daily : [Daily]?

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


struct Current : Mappable {
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
struct Hourly : Mappable {
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
struct Daily : Mappable {
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
    var uvi : Double?

    init?(map: Map) {

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
    }

}

struct FeelsLike : Mappable {
    var day : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        day <- map["day"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
    }

}
struct Temperature : Mappable {
    var day : Double?
    var min : Double?
    var max : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?

    init?(map: Map) {

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
struct Weather : Mappable {
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }

}
