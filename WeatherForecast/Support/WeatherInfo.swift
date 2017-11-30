//
//  WeatherInfo.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 21..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

struct WeatherInfo {
    func getSkyState(code:String) -> String {
        switch code {
        case "SKY_A01" :
            return "맑음 ☀️"
        case "SKY_A02" :
            return "구름 조금 🌤"
        case "SKY_A03" :
            return "구름 많음 ⛅️"
        case "SKY_A04" :
            return "구름많고 비 🌦"
        case "SKY_A05" :
            return "구름많고 눈 🌨"
        case "SKY_A06" :
            return "구름많고 비 또는 눈 🌧🌨"
        case "SKY_A07" :
            return "흐림 ☁️"
        case "SKY_A08" :
            return "흐리고 비 🌧"
        case "SKY_A09" :
            return "흐리고 눈 🌨"
        case "SKY_A10" :
            return "흐리고 비 또는 눈 🌧🌨"
        case "SKY_A11" :
            return "흐리고 낙뢰 🌩"
        case "SKY_A12" :
            return "뇌우, 비 ⚡️☔️"
        case "SKY_A13" :
            return "뇌우, 눈 ⚡️❄️"
        case "SKY_A14" :
            return "뇌우, 비 또는 눈 ⚡️☔️❄️"
        default : break
        }
        return ""
    }
    
    func getSkyImageName(name:String) -> String {
        switch name {
        case "SKY_A01" :
            return "sunny.jpg"
        case "SKY_A02" :
            return "cloud.jpg"
        case "SKY_A03" :
            return "cloudMany.jpg"
        case "SKY_A04" :
            return "rainAndSun.jpg"
        case "SKY_A05" :
            return "snowCloud.jpg"
        case "SKY_A06" :
            return "snowAndRain.jpg"
        case "SKY_A07" :
            return "notSunny.jpg"
        case "SKY_A08" :
            return "rain.jpg"
        case "SKY_A09",
            "SKY_A10" :
            return "darkSnow.jpg"
        case "SKY_A11",
             "SKY_A12",
             "SKY_A13",
             "SKY_A14" :
            return "thunderstorm.jpg"
        default : break;
        }
        return "defaultImage.jpg"
    }
    
    let detailKeys = ["관측소", "최고 기온", "최저 기온", "바람", "1시간 누적 강수량"]
    
    func getDetail<T>(name:String, weatherType:T) -> String {
        // to do
        if let weather = weatherType as? Minutely {
            switch name {
            case detailKeys[0] :
                return weather.station.name
            case detailKeys[1] :
                return weather.temperature.tmax
            case detailKeys[2] :
                return weather.temperature.tmin
            case detailKeys[3] :
                return weather.wind.wspd
            case detailKeys[4] :
                return weather.rain.sinceOntime
            default: break;
            }
        }
        return ""
    }
    
    func getUnit<T>(type:T) -> String {
        switch type {
        case is Temperature :
            return "°"
        case is Wind :
            return "m/s"
        case is Rain :
            return "mm"
        default: break;
        }
        return ""
    }
    
}
