//
//  WeatherManager.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 14..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import Alamofire

protocol WeatherManagerDelegate {
    func getMintelyWeather(info:[String:Any])
}

class WeatherManager: NSObject {
    
    var delegate:WeatherManagerDelegate?
    
    override init() {
        super.init()
    }
    
    /** Mintely tag = 0 */
    func getMintely(city:City) {
        let weatherURL = "http://apis.skplanetx.com/weather/current/minutely"
        let header : HTTPHeaders = ["appKey" : "c7c387b5-f5f7-3342-91dd-ae532e67ced7"]
        let parameters = city.getParmeters()
        Alamofire.request(weatherURL, method: .get, parameters: parameters,
                          encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                            switch response.result {
                            case .success(let JSON):
                                self.arrive(type: ForecastType.mintely,
                                            info: MyJSONPaser.sharedInstance.parsingJSON(response: JSON)!)
                            case .failure(let error):
                                print(error)
                            }
        }
    }
    
    func arrive(type:ForecastType, info:[String:Any]) {
        if type == ForecastType.mintely {
            delegate?.getMintelyWeather(info: info)
        }
    }
    
}
