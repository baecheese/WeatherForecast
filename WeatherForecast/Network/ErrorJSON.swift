//
//  ErrorJSON.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 30..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

struct ErrorJSON: Codable {
    var code:Int
    var message:String
    var id:String?
    var category:String?
    var link:String?
    init?(json:[String:Any]) {
        if let errorCode = json["code"] as? Int,
            let errorMessage = json["message"] as? String {
            self.code = errorCode
            self.message = errorMessage
            return;
        }
        return nil
    }
}
