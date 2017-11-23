//
//  City.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 23..
//Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    
    @objc dynamic let version = "1"
    @objc dynamic var city = ""
    @objc dynamic var county = ""
    @objc dynamic var village = ""
    @objc dynamic var fullName = ""
    
    func setInfo(cityInfos:[String]) {
        self.city = cityInfos[0]
        self.county = cityInfos[1]
        self.village = cityInfos[2]
        self.fullName = cityInfos[3]
    }
    
    func getParmeters() -> [String:String] {
        return ["version" : self.version, "city" : self.city, "county" : self.county, "village" : self.village]
    }
    
}
