//
//  MainWeatherInfoView.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 12. 2..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MainWeatherInfoView: UIView {
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var sky: UILabel!
    @IBOutlet weak var temparature: UILabel!
    
    func set(infos :Minutely) {
        let mainInfo = MainWeatherInfoDataInput(infos)
        
    }
}

