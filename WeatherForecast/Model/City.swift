//
//  City.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 22..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

class City {
    
    let version = "1"
    let city:String
    let county:String
    let village:String

    let fullName:String
    
    init(city:String, county:String, village:String) {
        self.city = city
        self.county = county
        self.village = village
        self.fullName = "\(city) \(county) \(village)"
    }
    
    func getParmeters() -> [String:String] {
        return ["version" : version, "city" : city, "county" : county, "village" : village]
    }
    
}
