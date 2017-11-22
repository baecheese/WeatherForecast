//
//  DataCenter.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 22..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class DataCenter: NSObject {
    
    override init() {
        super.init()
    }
    
    let userDefault = UserDefaults()
    
    func save(id:Int, city:City) {
        userDefault.set(id+1, forKey: "count")
        userDefault.set(city, forKey: "\(id)")
    }
    
    func getCity(id:Int) -> City? {
        if let city = userDefault.value(forKey: "\(id)") as? City {
            return city
        }
        return nil
    }
    
    func delete(id:Int) {
        if let total = userDefault.value(forKey: "count") as? Int {
            userDefault.removeObject(forKey: "id")
            userDefault.set(total, forKey: "count")
        }
    }
    
    func count() -> Int {
        if let total = userDefault.value(forKey: "count") as? Int {
            return total
        }
        return 0
    }
    
}
