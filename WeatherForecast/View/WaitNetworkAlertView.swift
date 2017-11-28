//
//  WaitNetworkAlertView.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 28..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class WaitNetworkAlertView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setWaitNotice()
    }
    
    func setWaitNotice() {
        let label = UILabel(frame: self.bounds)
        label.text = "network waiting.."
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
