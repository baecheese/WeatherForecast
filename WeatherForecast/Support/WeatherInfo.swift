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
    
    let detailInfos = ["관측소", "최고 기온", "최저 기온", "바람", "1시간 누적 강수량"]
    let querys = ["관측소" : "station.name", "1시간 누적 강수량" : "rain.sinceOntime", "현재 기온": "temperature.tc", "최고 기온":"temperature.tmax",
                      "최저 기온" : "temperature.tmin", "바람" : "wind.wspd"]
    
    func getUnit(key:String) -> String {
        switch key {
        case "temperature.tc", "최고 기온", "최저 기온" :
            return "°"
        case "바람" :
            return "m/s"
        case "1시량 누적 강수량" :
            return "mm"
        default: break;
        }
        return ""
    }
    
}
