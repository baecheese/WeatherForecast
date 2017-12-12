//
//  MainWeatherInfoViewDataCenter.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 12. 2..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

struct MainWeatherInfoDataInput<Some> {
    let base:Some
    init(_ base:Some) {
        self.base = base
    }
}

protocol MainWeatherInfoDelegate {
    associatedtype WeatherType
    var minutely: MainWeatherInfoDataInput<WeatherType> { get set }
}

extension MainWeatherInfoDelegate {
    var data: MainWeatherInfoDataInput<Self> {
        get {
            return MainWeatherInfoDataInput(self)
        }
    }
    
    func set(datas:Minutely) {
        
    }
}
