//
//  WeatherStatusBackground.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 23..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class WeatherStatusBackground: UIImageView {
    
    init(frame: CGRect, skyCode:String) {
        super.init(frame: frame)
        self.image = UIImage(named: WeatherInfo().getSkyImageName(name: skyCode))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
