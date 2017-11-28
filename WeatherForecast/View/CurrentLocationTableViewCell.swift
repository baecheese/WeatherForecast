//
//  CurrentLocationTableViewCell.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 28..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class CurrentLocationTableViewCell: UITableViewCell {

    @IBOutlet var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
