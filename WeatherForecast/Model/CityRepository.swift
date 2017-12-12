//
//  CityRepository.swift
//  WeatherForecast
//
//  Created by 배지영 on 2017. 11. 23..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import RealmSwift

class CityRepository: NSObject {

    private override init() {
        super.init()
    }
    
    private let log = Logger(logPlace: CityRepository.self)
    private var realm = try! Realm()
    
    static let shareInstance = CityRepository()
    
    func save(city:City) {
        do {
            try realm.write {
                realm.add(city)
            }
        }
        catch {
            log.error(message: "realm error on")
        }
    }
    
    // 특정 데이터 인덱스 접근으로 삭제
    func delete(city:City) {
        try! realm.write {
            log.info(message: "\(city) 삭제")
            realm.delete(city)
        }
    }
    
    func getAllList() -> Results<City> {
        let citys:Results<City> = realm.objects(City.self)
        return citys
    }
    
}
