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
    
    static let shareInstance = CityRepository()
    
    func save(city:City) {
        var latestId = 0
        do {
            try realm.write {
                if (false == realm.isEmpty) {
                    latestId = (realm.objects(Diary.self).max(ofProperty: "id") as Int?)!
                    latestId += 1
                    diary.id = latestId
                }
                else if (true == realm.isEmpty) {
                    diary.id = latestId
                }
                diary.timeStamp = timeStamp
                diary.content = content
                if (content == "" || content == " ") {
                    throw ContentsSaveError.contentsIsEmpty
                }
                else if (content.characters.count > 1000) {
                    throw ContentsSaveError.contentsSizeIsOver
                }
                if (nil != imageData) {
                    diary.imageName = imageManager.saveImage(data: imageData!, id: diary.id)
                }
                realm.add(diary)
            }
        }
        catch ContentsSaveError.contentsIsEmpty {
            log.warn(message: "contentsIsEmpty")
            return (false, "The pages are blank.")
        }
        catch ContentsSaveError.contentsSizeIsOver {
            log.warn(message: "contentsIsOver")
            return (false, "글자수가 1000자를 넘었습니다.")
        }
        catch {
            log.error(message: "realm error on")
            return (false, "오류가 발생하였습니다. 메모를 복사한 후, 다시 시도해주세요.")
        }
        log.info(message: "저장 완료 - id: \(latestId) timeStamp: \(timeStamp), content:\(content), imageName: \(diary.imageName)")
        return (true, "저장 완료")
    }
    
}
