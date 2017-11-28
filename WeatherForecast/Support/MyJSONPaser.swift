//
//  MyJSONPaser.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 14..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

private let _sharedInstance = MyJSONPaser()

class MyJSONPaser {
    
    class var sharedInstance: MyJSONPaser {
        return _sharedInstance
    }
    
    func parsingJSON(response:Any) -> [String : Any]? {
        if let dictionary = response as? [String : Any] {
            return dictionary
        }
        return nil
    }
    
    // 좋지 않음
//    func findGroup(datas:[String:Any], groupName:String) -> [String:Any]? {
//        var newDic = [String:Any]()
//        for (key, value) in datas {
//            if key == groupName {
//                return [key : value]
//            }
//            if let dic = value as? [String:Any] {
//                dic.forEach { (k,v) in newDic[k] = v }
//            }
//            else if let arr = value as? [Any] {
//                for a in arr {
//                    if let dic = a as? [String:Any]{
//                        dic.forEach { (k,v) in newDic[k] = v }
//                    }
//                }
//            }
//        }
//        if false == newDic.isEmpty {
//            return findGroup(datas: newDic, groupName:groupName)
//        }
//        return nil
//    }
    
    // 각 key별로, 객체를 만드는게 유지보수에 좋음 -> iOS도 그런지 알아보기
    /** usage: getByQuery(query: "a.b") */
    func getByQuery(query:String, JSONDic:[String:Any]) -> Any? {
        let terms = query.split(separator: ".").map { String($0) }
        return findResult(terms: terms, JSONDic: JSONDic)
    }
    
    // todo
    // weather.minutely 이면 array가 나옴. -> 이 안에는 하나 빼고 key, value인데 하나 때매 array 형태 ---> 객체로
    private func findResult(terms:[String], JSONDic:[String:Any]) -> Any? {
        if let first = terms.first, let value = JSONDic[first] {
            if 1 == terms.count {
                return value
            }
            if let newJSONDic = value as? [String:Any] {
                let newTerms = terms.remove(index: 0)
                return findResult(terms: newTerms, JSONDic: newJSONDic)
            }
        }
        return nil
    }
    
}
