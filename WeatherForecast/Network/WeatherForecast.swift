//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 30..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

/** common, result는 안써서 주석 */
struct WeatherForecast: Codable {
//    var common:Commons?
//    var result:Result?
    var weather:Weather
    
    init?(json: [String:Any]) {
        if let w = json["weather"],
            let weather = Weather(json: w) {
            self.weather = weather
            return;
        }
        return nil
    }
}

struct Commons: Codable {
    var alertYn:String
    var stormYn:String
}

struct Result: Codable {
    var code:Int
    var message:String
    var requestUrl:String
}

struct Weather: Codable {
    var minutely:[Minutely]?
//    var hourly:[Hourly]?
//    var forecast3hours:[Forecast3hours]?
    init?(json: Any) {
        // minutely
        if let weathers = json as? [String:Any],
            let mArr = weathers["minutely"] as? [Any],
            let m = mArr.first as? [String:Any],
            let newMinutely = Minutely(json: m) {
            self.minutely = [newMinutely]
            return;
        }
        return nil
    }
}

struct Minutely: Codable {
    var humidity:String?
    var lightning:String?
    var timeObservation:String?
    var precipitation:Precipitation?
    var pressure:Pressure?
    var rain:Rain
    var sky:Sky
    var station:Station
    var temperature:Temperature
    var wind:Wind
    
    init?(json: [String:Any]) {
        if let r = json["rain"] as? [String:Any],
            let newRain = Rain(json: r),
            let sk = json["sky"] as? [String:Any],
            let newSky = Sky(json: sk),
            let st = json["station"] as? [String:Any],
            let newStation = Station(json: st),
            let t = json["temperature"] as? [String:Any],
            let newTemperature = Temperature(json: t),
            let w = json["wind"] as? [String:Any],
            let newWind = Wind(json: w) {
            self.rain = newRain
            self.sky = newSky
            self.station = newStation
            self.temperature = newTemperature
            self.wind = newWind
            return;
        }
        return nil
    }
}

struct Precipitation: Codable {
    var sinceOntime:String
    var type:String
}

struct Pressure: Codable {
    var seaLevel:String
    var surface:String
}

struct Rain: Codable {
    var last10min:String?
    var last12hour:String?
    var last15min:String?
    var last1hour:String?
    var last24hour:String?
    var last30min:String?
    var last6hour:String?
    var sinceMidnight:String?
    var sinceOntime:String
    
    init?(json:[String:Any]) {
        if let newSinceOntime = json["sinceOntime"] as? String {
            self.sinceOntime = newSinceOntime
            return;
        }
        return nil
    }
}

struct Sky: Codable {
    var code:String
    var name:String
    
    init?(json:[String:Any]) {
        if let newCode = json["code"] as? String,
            let newName = json["name"] as? String {
            self.code = newCode
            self.name = newName
            return;
        }
        return nil
    }
}

struct Station: Codable {
    var id:String?
    var latitude:String?
    var longitude:String?
    var name:String
    var type:String?
    
    init?(json:[String:Any]) {
        if let newName = json["name"] as? String {
            self.name = newName
            return;
        }
        return nil
    }
}

struct Temperature: Codable {
    var tc:String
    var tmax:String
    var tmin:String
    
    init?(json:[String:Any]) {
        if let newTc = json["tc"] as? String,
            let newTmax = json["tmax"] as? String,
            let newTmin = json["tmin"] as? String {
            self.tc = newTc
            self.tmax = newTmax
            self.tmin = newTmin
            return;
        }
        return nil
    }
}

struct Wind: Codable {
    var wdir:String?
    var wspd:String
    init?(json:[String:Any]) {
        if let newWspd = json["wspd"] as? String {
            self.wspd = newWspd
            return;
        }
        return nil
    }
}
